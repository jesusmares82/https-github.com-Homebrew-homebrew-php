require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "21943c90f94dc54d328abcda0bfa13d7055cca48a69f6a9e38868b7f5f58f5ce" => :el_capitan
    sha256 "e30eb9a2eeb74284e1523aefc19cd5618c50b1f1adca46e4ca5809aa7a2d9dda" => :yosemite
    sha256 "5a1b2c897914f696fc07b43f6e81946887472c14dc070be3acfd690ec48435fa" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
