require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 11

  bottle do
    sha256 "031b875b42ab78e1791a1dae70819fce838a6ae90e2e64fe777fb918edefaedb" => :sierra
    sha256 "ccb4341f324d8722fe2e17657592790c433e356bcf5968dafc5d87725a67fa50" => :el_capitan
    sha256 "6cddad27ddc9cd4fea7a76af92fa376d32d4ca1fea631c0fab570af592bc1360" => :yosemite
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
