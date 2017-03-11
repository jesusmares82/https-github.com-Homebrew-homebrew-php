require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "75bf095f1c126dd126dca17860149083e60687bcb41dad455066c7241bae7107" => :sierra
    sha256 "3368ed46a362baaa02c83f2a5a2b9f3d74331a1366755fbfe3e33ac193062428" => :el_capitan
    sha256 "f813b925958e4c27601eabd870b32fa0669eacfe36768ce722a2e71a255afceb" => :yosemite
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
