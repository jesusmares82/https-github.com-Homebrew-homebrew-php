require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 11

  bottle do
    sha256 "2a1fded4a5c317341d6f1b7a286a0957ee35fe8d24fa90586d10c2f74c038d42" => :sierra
    sha256 "52728e8fc155de019e0b5bbacbcb68855633d5498e55a6b026d157efd5d11be6" => :el_capitan
    sha256 "a6ef0168bf4b2cf8a06dd6b9878a19ab67698c08ab09f14ea61af8fe56823184" => :yosemite
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
