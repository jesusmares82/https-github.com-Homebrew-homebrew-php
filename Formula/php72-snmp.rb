require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 3

  bottle do
    sha256 "8e9f06cbf5568a0bb04326ece6d9b5f7a0edf420706d65cb13d2f11f2e882875" => :sierra
    sha256 "45913024e3bdb8f8e0ab67ad7a17c32f2cdc579be48630be9313addc2f338f81" => :el_capitan
    sha256 "4114382c64405532ad5456a4c0475475c98d34b4ff2b6ad81542b515b4b3dde1" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

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
