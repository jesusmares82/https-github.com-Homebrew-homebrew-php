require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "f4b14dfbb6555df192285e0652e3b7ecaca204f63fea3b6875f720d7c7af502f" => :yosemite
    sha256 "5bf9e9a62085c0d3514d04efe52f631fc2ef33c8c62ccb7e7fb54889505f7f83" => :mavericks
    sha256 "1ec6883f5cdd1d06ec39d4ec481c2559aa7677d176dd19dab81abdd1cdd18364" => :mountain_lion
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
