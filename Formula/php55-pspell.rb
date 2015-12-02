require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "4834df6ee1b4671c5a8abc396a41b11fe2672ca1b430138807f77bd0c7d5fce7" => :el_capitan
    sha256 "f7e0aaee66c8ae6d2322e9347e14cd68ebe5381459b3bc085e8c0649a3863760" => :yosemite
    sha256 "17002d96bf85f1e10bb0c3b1bc1449854fd1df9b2d899ca46b0d45ebca5c3adf" => :mavericks
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
