require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "44ee2ea6c81901e04f67a47859f5456d1580e4e257347035ef6381cc70e7ace7" => :sierra
    sha256 "575b79eb36b8ecb48a5a08a532152c7a0fc0dfad524639000404ed5b6e6d3d78" => :el_capitan
    sha256 "a7da6b7929d0db14c92aee97d241683ee5971b4c35bcd245c52622fc82005f68" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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
