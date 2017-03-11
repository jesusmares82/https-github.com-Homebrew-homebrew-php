require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "dc229a5addcd90d18f71c555c6fd7d1648fa204930fbdb98cbae884319a277cc" => :sierra
    sha256 "44f8e860e86efd6e1d18f57f658e754b44e3ac14b9790e925cd309e11232a00c" => :el_capitan
    sha256 "415b927aa3b3ceae7103de33a1093f5377742700b5df1413927e0e52769ee8b6" => :yosemite
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
