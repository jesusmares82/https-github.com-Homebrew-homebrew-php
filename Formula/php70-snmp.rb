require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 13
    sha256 "a3ee2b10e28dbe40a1f48fa0bd2379bb95562a60584c2bcf3482606d11b3aee8" => :el_capitan
    sha256 "b6645fb074b720d4147e27c104f86004423f39a795a9921d13939ddb35605587" => :yosemite
    sha256 "9212f9cbfd18f42a45a032cfc6e215f092261cbd2423946595c8b421d5e8c601" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-snmp=#{Formula["net-snmp"].opt_prefix}"
    system "make"
    prefix.install "modules/snmp.so"
    write_config_file if build.with? "config-file"
  end
end






