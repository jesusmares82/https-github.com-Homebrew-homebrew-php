require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "98222142a17d1d220e4b853580cab91fb2d055f4c0669c0b4880c476db47b43c" => :el_capitan
    sha256 "d30513bd463f98e9fa882592fcf8a2824d6d5d9b673bf751ff1528fe4f9fc80b" => :yosemite
    sha256 "7fc5029082afc240fd0ca70d62c996c7ad758e6d4fa05dd8c4f6fbcf773df2fb" => :mavericks
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
