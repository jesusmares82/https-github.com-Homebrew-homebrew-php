require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "672a184eab1e2dff01d2ce51c44bd1972af1f15ff1e949f364853459417951db" => :el_capitan
    sha256 "a2f51b0b0e1fd09aea940fe6d4c5d9cd9a7653c4a07d4aa2e29a0e2f25d094b8" => :yosemite
    sha256 "449878bb9f55c54c52a88f5b7b5102fbc737d692ce906391ed0b403d55ee6bb7" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
