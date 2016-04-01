require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "48314a0c7f723036dcdf0b2f7d047985394fe6c760fa5f402b1597cd7e5aa3c3" => :el_capitan
    sha256 "c207e1450a1f108d89418cfbfd2dc7e51fa067055d58005ea11d6c5cdea77c3a" => :yosemite
    sha256 "d38eaa616b746f2bd27ef63997d86b5b08d197a39c9c2d9e2f75322e68a7a559" => :mavericks
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




