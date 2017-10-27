require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 16

  bottle do
    sha256 "b0e15549e4b33532eb76a6ab9b419e0c205c4f16923598cf1a232721176e2255" => :high_sierra
    sha256 "fb2e9462ab56888f3bcc0725296094673a18b8c5c3c5b484f20744cc4b0655c5" => :sierra
    sha256 "a4fdbbded056ad014d6588327727d89fdee3cd56ba07f83791a0962be6eb9ed2" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
