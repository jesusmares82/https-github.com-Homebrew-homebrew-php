require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 13

  bottle do
    sha256 "ae0ed55d20a989e91cea3eb2d7e119342e18b373e615be9e26f450da2eacbb43" => :sierra
    sha256 "8461f3faed7ca05f3c26c6ebb89f73894e85be16a1d8d1fb60382ce2bbdb37b3" => :el_capitan
    sha256 "a681b1e480073ffba5f793430158ec106e55bd05be892f33895d51053ffc659d" => :yosemite
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
