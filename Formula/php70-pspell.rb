require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 5
    sha256 "75d98a0d58f73b2b0a2f2485d27a33d89a2f6a162c023ba0d155926194f11423" => :el_capitan
    sha256 "a2deee324553007ed11ccc96b6df3edd2e9ad853dc22e4227e673901630685b5" => :yosemite
    sha256 "82a6880a71bcb95e5dfac77266df31bddc0fcc058a821667d4adf6087aded029" => :mavericks
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
