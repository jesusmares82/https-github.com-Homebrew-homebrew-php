require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "b04d44c8e285c02c295f056a2689ffb5ebbc2e664c9eb058cb08f7b8e18c3b26" => :sierra
    sha256 "0c3c19fe8a725ac5fa156abf1eb90570ba7e2f4d59b03612f85fcfcdc71945a5" => :el_capitan
    sha256 "67cd46892febb87172d50fb81706f3a61e4ccb018f03362aecf8b8c98fee51e0" => :yosemite
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
