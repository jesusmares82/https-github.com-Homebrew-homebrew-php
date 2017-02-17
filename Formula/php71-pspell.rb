require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 9

  bottle do
    sha256 "5d7b4e323ee27a2a36881066ce708a24efc8e6ac81c719d313b4f0b2fde80f73" => :sierra
    sha256 "c6ceb9b953b29e71e804e65dca6e6713add715bb48e82105dd8fcdace9c45eba" => :el_capitan
    sha256 "e72da90a51fbeffab2584bb70744878f94ae2da7fb86a1baf1401be5211a8be4" => :yosemite
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
