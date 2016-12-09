require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 6

  bottle do
    sha256 "93f7c294f7e2f2283bcb589aed71c428e3d9e3690504c844190e01e0f7a2f43b" => :sierra
    sha256 "f2768aab3c2767a910d66e39f6ade3ba88e6da2455008213079dea52ce609a3a" => :el_capitan
    sha256 "063226c60cc02ed15ad2c6df935b5d14859f4085e9431ad77e4c97c7d76a9023" => :yosemite
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
