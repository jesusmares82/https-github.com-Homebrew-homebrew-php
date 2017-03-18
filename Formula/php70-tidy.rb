require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 8

  bottle do
    sha256 "9dabe14e41aec47bc84d46000c2a1b59df081f34ae9cdf7b8f267677ea96e11b" => :sierra
    sha256 "cb4d45dde7c102573e7998a8b40151ec07fe80a3eabbb452973fbda1391edd34" => :el_capitan
    sha256 "0fd4cefcd739418eeebcf4ebbb14edab509098d72b371555943b28dd7436c05f" => :yosemite
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
