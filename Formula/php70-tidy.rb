require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 10

  bottle do
    sha256 "3fb6ab3b6d902404cd43b257bf6b8c4492f97922f708ee51cf571ec9014d3a38" => :sierra
    sha256 "2cf1ec151ecca4ac9a0a31ee5360331eae04fb5650894789f6a8410e6548a089" => :el_capitan
    sha256 "c9d8e2ce819545f243dfe8ae61088e462d35a4b4a7f5b2b8abf7a9ec8e54edf9" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

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
