require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 18

  bottle do
    sha256 "774cc3ba3c1a5f694bdd6df19683a999951e0d93d5861ca58bc3f93115270591" => :high_sierra
    sha256 "8d68cbd8f0c68e578a60291768c4cacb28711f44e74c4afae9b925fbb5a71684" => :sierra
    sha256 "fc6bfe8077804f1ef0cc0bc46f4853b4f436a0cdd16311fe49701ec434efc38a" => :el_capitan
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
