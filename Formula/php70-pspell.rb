require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 7

  bottle do
    sha256 "88e14d44e1823d5d9ff4462eda3b4270897d05d62688ca2733346c005d83357c" => :sierra
    sha256 "bea56ae811d6229095d4af40c547a2dedf347128225687f5a636db86d28fcd6c" => :el_capitan
    sha256 "19ccb083d91da4854073cee1b9af800335603ef7f33849cf44acca69543985e6" => :yosemite
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
