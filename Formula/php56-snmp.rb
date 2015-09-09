require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "c0020540ba06493a24a463b8c77e3e14ec8933f8c65b680c8e7feac1f65e90e9" => :yosemite
    sha256 "5fba7b8c73c266c5900897b509ada9c7d3836a276cbd5791fd5372b3313b0d08" => :mavericks
    sha256 "0499835fe458b995fe3dfbf14ff703804a07c302f5d12bc3ed78f1632f802f7c" => :mountain_lion
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

  test do
    shell_output("php -m").include?("snmp")
  end
end
