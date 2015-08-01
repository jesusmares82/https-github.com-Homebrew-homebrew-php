require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "97889f531bcbd29d6329ad749ec40c1696379493cb7726fff6e58b57c5f86bd1" => :yosemite
    sha256 "335a4d3924a542d10c7a4b0715987e6ab4bcb79ad291a53e12712537a5a00617" => :mavericks
    sha256 "34b3f13211fe8a58cb3b0f306f48038e823e6330896b62744e82cbe98f6ea6b7" => :mountain_lion
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
