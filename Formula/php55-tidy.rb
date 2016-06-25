require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 8
    sha256 "a0d9061da8994be323d24f44211fa4479d3c4ada8c83664c2cb94cfad39b37d6" => :el_capitan
    sha256 "e87648c0de54dd7f28ebf3a90bd353fb0f6205c42a4a5c07ae2558893811bac8" => :yosemite
    sha256 "5eeb81e138135fc126528048f0bc6dff35af7d1b33758d87e0243d76d79c1da0" => :mavericks
  end

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







