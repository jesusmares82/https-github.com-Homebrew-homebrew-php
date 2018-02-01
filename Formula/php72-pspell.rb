require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 10

  bottle do
    sha256 "e577eef57ff6176476af8c92d088c073b0aacd902aa244652dfa90c6cda46582" => :high_sierra
    sha256 "0461c9d3b79ebcc49563671734ee1cef5d8f604ec5b999ac5c603508b84ef179" => :sierra
    sha256 "73686a8f46597db471836740aca4376f4e55264d306962373f58837084fecd21" => :el_capitan
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
