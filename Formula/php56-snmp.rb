require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "013613b0487e635183467c87975dc29021e9e93552d2cb449b60abe00ead7767" => :el_capitan
    sha256 "71f5a0cb412d1f1b7173389148a6ae1dab5fb5f447b8b51a55b0043a381b0d05" => :yosemite
    sha256 "9623ab0e4a9c98f2b6d69e70c8f37bede925e4f1d40d85b3a67a35ab80a3468f" => :mavericks
  end

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
