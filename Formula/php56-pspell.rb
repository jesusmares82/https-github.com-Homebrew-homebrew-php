require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "33ebc108b5d9f6bebcb225ae9c753f0d028c03dc8185b56429d51bf9c56dcb91" => :el_capitan
    sha256 "a7e1aaffc7443e9751e23e093a48ef30db1b3f000ab6fae6ee9b8808d7f7bb4f" => :yosemite
    sha256 "021db2be1e37f585cda7c72169eae8716fa7abd90f6cdfde4848bd395a534f44" => :mavericks
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

