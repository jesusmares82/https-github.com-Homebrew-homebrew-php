require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 2

  bottle do
    sha256 "b08b4825a3f8d016971bce668d703ba364a3e1450aaee58cb567aa84c70a5dd6" => :sierra
    sha256 "478fbc1d7d3421b78a7ae1b551acc3a884255bef5dd7138e0711259b7dc30952" => :el_capitan
    sha256 "d0f8ecba3149f7062a3b46233a948ba791b6a175f28f077d9b2a711407f6bfa3" => :yosemite
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
