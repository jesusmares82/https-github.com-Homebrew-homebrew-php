require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 11
    sha256 "e3280b0d07b5c8ecd083ace288f5a346c3b39885f8998e1c0c85deea1cfb6ff5" => :el_capitan
    sha256 "4b1c7c03b7f076f1771b3c94b7bc8e23be81705bd9737780fff6dbf91122e447" => :yosemite
    sha256 "f9d1effa4d3c4e481014c14a189eed60821059d5be9b86ba9759b745c52be716" => :mavericks
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



