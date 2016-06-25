require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 11
    sha256 "e0035c250359d8dcd7e03d28adb159f7cb642b4f65e1e752449e2cc747a60a78" => :el_capitan
    sha256 "55cf7b4f9dd5a36585141a3352915f07d5d436c2623651e6f5d99a6b413839b7" => :yosemite
    sha256 "d57085f7de4501cf0fb8b67488ef24afec9ba756c57996a060f506c1c43175b0" => :mavericks
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







