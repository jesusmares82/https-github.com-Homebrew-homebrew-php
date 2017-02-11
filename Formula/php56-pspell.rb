require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "f82294e34ee925f78919a29888f5887f66aebdd18286c742cde0edfd808697e7" => :sierra
    sha256 "702dec3b95a09bb419e32e49c9ca1a7e32aec820c43dc6ba14b821415e87cc06" => :el_capitan
    sha256 "049d99beb9377eb7ee0c22623c1eb2338a2c70215087d480c28db90cfa276808" => :yosemite
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
