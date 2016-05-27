require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 8
    sha256 "1708d674c7fa8c067ecfb435a115a1aece9ebea4dd36d9a4c8794834b9328695" => :el_capitan
    sha256 "addf68e201dc35c9cb292720d78d5d3f859e147520f2decfb241c7bcb6b7506f" => :yosemite
    sha256 "1efcfe50ca036a6c31a51638552dc340eebe1dba8726d1ec9043fb40175a67b5" => :mavericks
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






