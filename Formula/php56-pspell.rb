require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 9
    sha256 "7de323ae5604e91a5a1365dc88ed2491e23004fd72939fb38ac42b90e886e3c7" => :el_capitan
    sha256 "06930764c56bf6ba5d585cb7e03a20e0e0f9237c813703973a33096ddc87e3a2" => :yosemite
    sha256 "69e60082018e72f4e399df57917b2e8ae3770b8664a02b7a89308460b560f07f" => :mavericks
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





