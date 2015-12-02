require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "d2c5cddcb0ed3cfcb2982f8bf3defa3b41bfc4a664f0177d9ea3efd916f182ea" => :el_capitan
    sha256 "76d919bd94dbd95c5152e9ff8bdb4c3ac168e1675bc721e6d54f5cc88e3bd44e" => :yosemite
    sha256 "2a7f2a0ad97e67b211870dd25df8d67b686e384d6c72fc4e3740a8f172c30881" => :mavericks
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
