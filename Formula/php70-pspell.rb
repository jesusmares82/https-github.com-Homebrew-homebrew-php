require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 6
    sha256 "1b022f879587121a7593025457f7a3b5da404e20f23cf6ef7a578d82a9b44932" => :el_capitan
    sha256 "85eff85ee8018a64b108ec31c06c01d1e675b234d6ca7f0ea59e6c3fe24b761c" => :yosemite
    sha256 "716254975c60420512fafef8ebaffbe1862aa0d6c3c4c6834ffaa8dd97e77bfa" => :mavericks
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
