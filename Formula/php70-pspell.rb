require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 10

  bottle do
    sha256 "81e1839f54558d3bf800e7c9a1e4a7d8dad16e6d271f7184387395f1c88f21a5" => :sierra
    sha256 "40b6e7e52bf324bb1b58cf056345d01d211d2eb673fd146b1e8dbb0c19cf9f9c" => :el_capitan
    sha256 "720908fe13b25662c4144c92c12b990c371dd39c1e8ef5f560c1562cf1214819" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula["aspell"].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end
