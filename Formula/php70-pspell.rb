require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 15
    sha256 "64da198067ef4ffb6fb014b198de4c0cc682de19d449e39d7672a6704be3f58e" => :el_capitan
    sha256 "c1bf3504dc8842f2480802b7360d2567b0ffd342634be8f482aea22ab07e7bc5" => :yosemite
    sha256 "6a68f2c356ade46f858bd5e4e9558407348df21d132b50a2dc50820dfd2eef4c" => :mavericks
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








