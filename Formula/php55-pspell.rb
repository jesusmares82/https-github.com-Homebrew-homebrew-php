require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "d05ae27613f9b313c3fa611dbb6ca90d9eeaa292258586d78f5d081db95f6db7" => :el_capitan
    sha256 "e369a8f6e5be9f0a7a0f0f95ac11b7d1b1408f2172ba3c06c61b32b8ddb62af9" => :yosemite
    sha256 "40f3eb38c0434e2d49fb77ef78ef5b72203e2ee2b26c40c37f51ed967381429b" => :mavericks
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





