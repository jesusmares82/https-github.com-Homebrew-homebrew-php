require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "37bf5c35469136b28cd5ae25878e7648773e11817df652d88852a19a8d338529" => :el_capitan
    sha256 "e1141f5a3d3db41c72009c255a1885cc1e36b28fa9ba010544fca7c8955ccd02" => :yosemite
    sha256 "132005748cc6e65b8a797af582d8f3ecde9cb36b6117193731760c5c50502215" => :mavericks
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





