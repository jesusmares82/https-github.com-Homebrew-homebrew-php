require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "53c0ce93a44852151b79f0b3f6055dbfef2f113f34c214721ae2c157d3e2d1fd" => :yosemite
    sha256 "58d19f9f3a9b6f6e5279a56022ed9b6fab03701635d06f129a37f2c7e09e6e23" => :mavericks
    sha256 "2f59e032db711b350fa0aaf1e1b584ec551ea41dc751885bcdf2ae2e04c0ba78" => :mountain_lion
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

