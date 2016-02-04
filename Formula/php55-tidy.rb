require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 4
    sha256 "39d35c5aef008a057579d9e1a9b76ce60a9e00e82345b6892bfeac2417b9ed58" => :el_capitan
    sha256 "4da9a1420bc930df852805e952e92a51d73b81e839470b0a0f7e2ba55c77a9f5" => :yosemite
    sha256 "6660a92091153c10597b21f1435782a6aa02bf0d9784eac5e1e5792b6303bcde" => :mavericks
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


