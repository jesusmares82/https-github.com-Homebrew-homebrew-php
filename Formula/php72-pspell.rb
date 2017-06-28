require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"

  bottle do
    sha256 "a69227d5b69483f5ae44e08322c6c0a91ff775018071a26a5f1b1ca625bda79b" => :sierra
    sha256 "65ba23f80762d059963c04e1416e8f64f176e99c6c437268b5f35ea18bcde281" => :el_capitan
    sha256 "07af28260a44e7f78fe27ddf265efde39d20930ab7238bf2710346d71a84f3f5" => :yosemite
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
