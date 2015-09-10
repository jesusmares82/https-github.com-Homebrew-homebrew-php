require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "bd3093cbf043012a46cca8ba871751d749c7f2529a9ce74f3fefe8562b13a799" => :yosemite
    sha256 "2a53d587e7e37e1eae13f028a55207d75d34c35034cc810f01b5c95743e49f58" => :mavericks
    sha256 "fc627efc83dd41cf4dd4ee2f76dc5a86b85a2590e8c915833ed8f4f252dd223e" => :mountain_lion
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
