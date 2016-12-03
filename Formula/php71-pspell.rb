require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 7

  bottle do
    sha256 "db2c5fd85f577fdb034702e65dea21062f7722f8d67bb1b3330a275c28108161" => :sierra
    sha256 "c52675dc4c529e1454ca1cccb568ad4b0eb18391c6c245787962ce886959bcf6" => :el_capitan
    sha256 "cd7fe2b03ca8a3a3353b8e3936962bd5e34ac4c2359ac812e5cd89b4ea48593b" => :yosemite
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
