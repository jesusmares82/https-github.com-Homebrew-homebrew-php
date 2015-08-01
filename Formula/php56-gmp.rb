require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "f4c2c52097133414a28ce6a5c24217b7400d31f33f766856e1ddd98065defed7" => :yosemite
    sha256 "609abbeb44bfe70391b57bce65b0b25d004893f922d92d4bbd9f5000bf3851ea" => :mavericks
    sha256 "9eb12ece39b6d06cfa33f4d3f51eb892204ccfdea1ec0e1f9c379f72e976c525" => :mountain_lion
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("gmp")
  end
end
