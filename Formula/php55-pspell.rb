require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "8c6306141aa8b144d98fdce08ac3da719b56f39cd2041e72678fad8e7d9935ab" => :el_capitan
    sha256 "537e286ee76fd3ab7320411f892bc8f24535d26e4943ad202b386b60bdcd0cdc" => :yosemite
    sha256 "2b5d95edab34b34b5e21b16a670b8f45f92dc19229ce845c1b032ef2aeea1ef9" => :mavericks
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


