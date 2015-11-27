require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 7
    sha256 "b13f7d2ceaadff5d8e0c01999ad75c2f2c2f990f28fc923353a6e55d1fff47ec" => :el_capitan
    sha256 "0beed9575f76564e5d881784b2362a46f8c030b177cb45500394e8f3ead7d551" => :yosemite
    sha256 "da69b26d752068fbed27197c0e12409e64bb207cb1a41aadcf28ae1a38b5d9a0" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
