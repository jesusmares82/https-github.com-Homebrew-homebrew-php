require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    rebuild 13
    sha256 "cdc7301b5f302b4752bf8ed8bc9374a6e301918996df18612c03a23a19faa9b8" => :el_capitan
    sha256 "1a75282e7c8b63ff03e1d90412322261f10b5931ad9f042a69bae64497f5ac1e" => :yosemite
    sha256 "799c06c52dc4b7de1022f96a7664a544af7dc68009218287d71654abceee13fd" => :mavericks
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
