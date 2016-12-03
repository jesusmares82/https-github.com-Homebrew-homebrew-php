require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 6

  bottle do
    sha256 "213aa307bb8bdf93a1b2c88da9828b7dc8505bd4ca64bece56a7324f9e5f5dbf" => :sierra
    sha256 "c6c1260e0ce246cc40437209d7b3fd6694554a52b3dd4fa22e828971ecd9212f" => :el_capitan
    sha256 "147c941f6bcd7881645243e77e4ea7dacd296b85577196b05734aa8f12390b70" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
end
