require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "049d13dc1f9e0dc6e8101262940a2299173e6c40de314df2f5a61e7e221e2d06" => :el_capitan
    sha256 "5a77d2b2a64ddd018dbf0e6961188ddb48ee2fb71254f97cbe315ed29a4fad89" => :yosemite
    sha256 "34fdb88dd6a3cb57124c3bfcd59631beebbb005f4d6ee1cb5af79f4b3c604bb2" => :mavericks
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


