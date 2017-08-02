require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 2

  bottle do
    sha256 "cac97bd37258e35a7ffc70c922e0967ae10efb57ed039e80f293dd082f5c2a1f" => :sierra
    sha256 "73354522cfcd39daff1a42bc0608569805372b0e902ae106d19de3f4b2d1df5d" => :el_capitan
    sha256 "23543d04e0ed89ff7dbc56ebfcc1f9a47fcd98602cbe1ebb1e50b31db038882f" => :yosemite
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
