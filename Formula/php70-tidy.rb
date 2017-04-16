require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 9

  bottle do
    sha256 "03fa669a6c9fbf6e7c8ed96e50b2e4d10dbaa6b2a6e1fa0fa153617dd3a2b4d4" => :sierra
    sha256 "9a82a119b76b9ba0cb2da0c5d063da2bb36d184c02d9db56527b7a8f2ccb88af" => :el_capitan
    sha256 "7ae3007505e0f9d24708c04bde9282063412bb6731640ef2fdcb5f30a04e7c64" => :yosemite
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
