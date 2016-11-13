require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 6

  bottle do
    sha256 "2c2ad6c67929430befebebb4029ac82b6608dc357c877c76126bd37278b24e9a" => :sierra
    sha256 "04e2dcd5d4384d22eb9a813349277ec199bc757baa336357d6f79b9a34f1ad4b" => :el_capitan
    sha256 "fcc519f5f41653233714ad2de522ddb74ddf6b3d20c0fbb76d1f3f14dc3430b8" => :yosemite
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
