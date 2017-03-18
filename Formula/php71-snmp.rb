require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 9

  bottle do
    sha256 "10e6452aa160d918fa1ebce24c6f9aa391a921a7aa792b0536c1649779d23050" => :sierra
    sha256 "b080437ee68d6cdb9e37d2633cd0b1fc994a44f9f6f10840f153239c062d7d20" => :el_capitan
    sha256 "57cfbcaf312887bcc9bb13f18683b3cbf308d9b0d12ecb1c1bf4f4e249f9a768" => :yosemite
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
