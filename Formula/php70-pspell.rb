require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 13

  bottle do
    sha256 "628a260b85a5c4bfcc888d2a1ad665debf52f1cb4e508234a1b2f27115ae5d03" => :sierra
    sha256 "1a6d12a1aded2681cd03a3fdc4628493d053d2a58f29bf484f6474f2e9d698cd" => :el_capitan
    sha256 "46565b5e48cab4650a558bc28b94639b2ed917415cad1dc6389228b70ab406f7" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
