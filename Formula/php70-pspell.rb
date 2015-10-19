require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 4
    sha256 "34995f3d7b598d4166bf4632b4fce816b471ca0ba1621d11c215f20c81e062da" => :el_capitan
    sha256 "9b8bf2597543701501b3e5ba691c6b41f2b00d72155dc1a10a1d8808837ba5ad" => :yosemite
    sha256 "00fe59e88ca3bcf9b09c47dd36800d4bead34a8285d9fa1c788f63809e2dce86" => :mavericks
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
