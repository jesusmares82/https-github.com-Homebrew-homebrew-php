require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 7

  bottle do
    sha256 "8a374378a60683e402ecbf2ffa5f76bf7688e6e8fbef1d3d389c9c6514495f37" => :sierra
    sha256 "e6283b01ffbea1e21015bb7d925e73f872dc1462f31b8305d90f7a548e6116b4" => :el_capitan
    sha256 "0a723974afbabe4ae2d4555da48d710235d46db9176a8924577b01be1e59501d" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
