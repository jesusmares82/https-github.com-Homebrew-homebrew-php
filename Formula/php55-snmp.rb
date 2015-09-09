require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "e8d7c689c4e841db357b99ff647975af76b37c55dab2d670c5da51378328e09c" => :yosemite
    sha256 "3b896196762d627844ea03fcfa411329add5f68dcec091d9600115f7f5d33e21" => :mavericks
    sha256 "d2cc91833b3b2a3259a3f32e6440381f5b483deb8bb1f591af89b10495998609" => :mountain_lion
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
