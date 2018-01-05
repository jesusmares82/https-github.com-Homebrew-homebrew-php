require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 9

  bottle do
    sha256 "2984ab23828bd87cedf9adbf7d5c1a2d3c614151f11aa18c6780935f9af4d5ab" => :high_sierra
    sha256 "731180d8c8bb051fe4ac0ec1e4909e477790e23cde5480ee6b9b86e8868b4bdc" => :sierra
    sha256 "deb459b7795a059d60d6778fb12c7f310183fcf7b95d585e7e0e3e8d8ba411e3" => :el_capitan
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
