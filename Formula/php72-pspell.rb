require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 8

  bottle do
    sha256 "23c2991965aff52eb38c1a6d904dd1340b5c315d9507467582c68fcb4591f6fd" => :high_sierra
    sha256 "e4a35636946d0ae09e9335b27be7a2fe14a0163b9206c542de8a17471688b775" => :sierra
    sha256 "9f5bd4a58cb7f7e8a3fad70e684fbda393c4b049fe5c083d05898b0bfeeb64ab" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
