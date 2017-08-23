require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 3

  bottle do
    sha256 "79403a183c9a3562108a69a6547932ccf4c2a2b77edcab36a936b5804f7b6370" => :sierra
    sha256 "438ce9548e6b7042f870a24f15ab5511636591ec0d5994dc4913048879cd23f5" => :el_capitan
    sha256 "667cf58264bd4bd536864d4c9cd720e3ba01faf1608208108289210dc8b354e8" => :yosemite
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
