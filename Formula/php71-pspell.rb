require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 17

  bottle do
    sha256 "4e6c08b4f201eee837442e5aa279ebe9a391f7be65a3071fbcb892da2d6c21b2" => :high_sierra
    sha256 "093c13880c5763c323d5bb34de02b1e032d0bb498434db4395f4e4b561a5176d" => :sierra
    sha256 "43efc0f61be595974231d428fa6f188475f6f2c32ce41449c1758db67d39e7c0" => :el_capitan
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
