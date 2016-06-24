require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 9
    sha256 "ec253cd0f2e62650f1e5ae0f3480de6e6558cd94788aa25652c94b86f54cbfb9" => :el_capitan
    sha256 "960fad5dd640e3a0f543399782815e8c6070acf14f79a500658325db5679536b" => :yosemite
    sha256 "b6d4a5d0056b3ebc247b51172a4e68fda7a74e8a9b281e40c3ed74648b4290a2" => :mavericks
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







