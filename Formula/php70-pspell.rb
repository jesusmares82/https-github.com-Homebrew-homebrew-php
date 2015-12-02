require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 8
    sha256 "45b61bfd77e9ac5ab43e8dc78a772ef13eaf30d0c3b889a6a4eebbc9907c3d47" => :el_capitan
    sha256 "3278db5756d27d6c0e69961c2836dce7b2cb865f8647daa1c37093664dbf369b" => :yosemite
    sha256 "61200147a4b919adf0ffa0d71c1979ca6cf7fedd38b4195ed071af986aba078a" => :mavericks
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
