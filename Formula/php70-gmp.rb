require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 9

  bottle do
    sha256 "7e2c6aedc5ce5c5610c6b1b81d933928f41e7d2cf1c36d51c814b3538075dffc" => :sierra
    sha256 "3a4d9ce408f8f7771c77099853710e711ea51b55b6b63f71da7fce9eb7056584" => :el_capitan
    sha256 "cb65ab357a1a5dcdbeed0688c474c9528a5a1133bc8effcafbb4340f1f05194f" => :yosemite
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
