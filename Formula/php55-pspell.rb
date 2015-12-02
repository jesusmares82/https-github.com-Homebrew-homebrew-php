require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "12150c3d7435d45f0f4d3520821cdd42f0a97012583784c844a6ae7aa8175afa" => :el_capitan
    sha256 "0b0f20f56edff991648dc557e6d545a222de3d079ffa5d480b969e195a816f17" => :yosemite
    sha256 "1cf312384c46b1be179316c126dab08a5f4aac1754d0922b4b06f34ce32e1d6d" => :mavericks
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
