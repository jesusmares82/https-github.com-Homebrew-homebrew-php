require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 4
    sha256 "c810b8c4d523e841aa0e0f91ca79826d8eba387f4845f637e1f67c93a4a4ed3f" => :el_capitan
    sha256 "4a7d8e640827bd1368c7b33299d84aed4a5b41816c2d71fd0e889e1eb8844506" => :yosemite
    sha256 "d07674088ef1c26b45f0355f3a010ed147772b184a5ad5f6d778e307b3568d01" => :mavericks
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
