require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 20

  bottle do
    sha256 "c44df84f1922bbd62397b983d0346514217a1de8f8d46a08e29a698fad5e6030" => :high_sierra
    sha256 "792f3b818f320ee495286057e855421f2e443d633fa5307b15d314fab3c2fbbe" => :sierra
    sha256 "0a9b3fafde0cb3ebe33ae792af846ca6b0ab7653de96bccc63d440d7989e0a4d" => :el_capitan
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
