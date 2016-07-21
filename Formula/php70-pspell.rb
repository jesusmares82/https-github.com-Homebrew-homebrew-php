require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 16
    sha256 "8b0692587b3bcc20ec3185c0921880da19150b73dddc9148c9adf0c5560fbada" => :el_capitan
    sha256 "06886bdd15878622f7c848d34342e9fecc2059d2b29edc217d005db45a02ad20" => :yosemite
    sha256 "808dc4b094d70ab601dc521843274c1d93c1b4a8afe47df69ba0d76568fd1619" => :mavericks
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









