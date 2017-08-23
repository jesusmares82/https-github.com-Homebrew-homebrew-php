require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 3

  bottle do
    sha256 "18f9b8282f34b53752f3f5e5b76fb8f2e7ecb914c0e705f379a7e6466ce83d11" => :sierra
    sha256 "212d6b4423df9a1202af667e4ac6cef26f663b67a084b94d1690ab1d6fd6bb8a" => :el_capitan
    sha256 "851904aadb54319b9182bf9ea8e857845979ce0c5e26e853b90e7b3c65b599e1" => :yosemite
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
