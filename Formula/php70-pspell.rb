require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 5

  bottle do
    sha256 "727614eeb8cd5f6a5a6703082f38aa493517db93df5d0203a147096031584d22" => :sierra
    sha256 "0e7e615c4e31e8274e9a02721e80e7dab4d8812f08b0bc9413376fd2ae6f43ad" => :el_capitan
    sha256 "55459433330b572f30b2046a241ee563365536d545fc1d7dceec09d461f4e3e5" => :yosemite
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
