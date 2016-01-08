require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "a6ce9964b762a0ea752ebfaa140f27ec8b86d97510387b23a51addc660ef2c5d" => :el_capitan
    sha256 "11a0b0760b09685e35b45ac1ae289dff18f605b6dfc04fd3dae9af963727b28d" => :yosemite
    sha256 "0ff91e19a65bc5245e2fd9a2762583591bd877bb0c37107c0ba502ec2b9b11c1" => :mavericks
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
end

