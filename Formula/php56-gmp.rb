require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "787855c593b9f70c30e10e0e0e1e3ffb8039b9e906a5bccd25531ce79f84a498" => :sierra
    sha256 "b0f90b1d5bfe51feeb5c42a8be6ee01f4068697ed3d2cdb37405f44eb2bfe0b4" => :el_capitan
    sha256 "d9253fb1b11513b8b86a7343600b9f0f7d4798626cd84a29b202415aba9b8932" => :yosemite
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
