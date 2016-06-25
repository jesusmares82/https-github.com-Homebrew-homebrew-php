require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 10
    sha256 "783f12eb804bdba94d71c5172f3234fbc505ffc2e3f92b5ce06ea1ffd0ccc206" => :el_capitan
    sha256 "6fab43a1e33d084ed1688c45ac1edef45fc75d763da0db3f83b78be0b24aaa96" => :yosemite
    sha256 "b9d23d2f44cf4db607f330bfe5e94309d6615b4c6a76510055636639f12d0210" => :mavericks
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







