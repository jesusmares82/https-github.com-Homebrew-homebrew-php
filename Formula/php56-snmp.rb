require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    rebuild 12
    sha256 "b7e2663116c34df2a0e5a17554b53e08ac6135279ef355563bbb6eb9f00000de" => :el_capitan
    sha256 "847467c14f5ff6649a2bad5e0a91f390d28a5dc8f4fe8d9e1875bd673179248a" => :yosemite
    sha256 "50b271e03266fb3a7f7b32f453d6fc07ccd3a6f25bb7266d65b27d059714c296" => :mavericks
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
