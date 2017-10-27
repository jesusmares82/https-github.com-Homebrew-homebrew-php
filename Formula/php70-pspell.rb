require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 16

  bottle do
    sha256 "72a4eba08af678da9b2b198206c9993a525a96450c67becc6955b65f363cff8e" => :high_sierra
    sha256 "4faa22b8d7af60f0ccab03d7ed9b8340c01416d869d18f41072e96a62c6331ce" => :sierra
    sha256 "f372e0bb6405f46952faa701d4c80fa633c898c8344a2e330c8592a3cebbd768" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
