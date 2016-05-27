require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 10
    sha256 "4ffaa1af027d4c7bc4665947c9b82e3819bd3a3944db218f86eaa8ffb7722ad1" => :el_capitan
    sha256 "881f9661e1e65d6c16d60461ac58d2f9ceb84b0f99edc34670cb1a72506df2db" => :yosemite
    sha256 "bbc34747b7666a9e40dc58c1de7721bdc20e7d5c17cd3c7a999512c539f2aa13" => :mavericks
  end

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

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






