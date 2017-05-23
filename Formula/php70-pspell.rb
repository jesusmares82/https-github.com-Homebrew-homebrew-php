require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 10

  bottle do
    sha256 "1179c7670c1123475a08d6c73d55039c0dfbd8d0dc3e1e54041c981cdd7bd50a" => :sierra
    sha256 "cbf82c7db5e56b195ce9258b1286f30b0ec36d2efdc23bf499dbffe29bdd275e" => :el_capitan
    sha256 "5345c5ade074f9c3e0b74bbb988a5d5cb72f4c053e6646b89305326fdb80b398" => :yosemite
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
