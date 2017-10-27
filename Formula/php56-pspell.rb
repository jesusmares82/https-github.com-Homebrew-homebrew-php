require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 5

  bottle do
    sha256 "0e899157c022acb0ca010cbeb7e889d5e7ff3550fa951b0e25fc0839cadb6113" => :high_sierra
    sha256 "c3419788a61f61acb8d698d5f30335217f9649f3a32c38857be204d53d9e53d9" => :sierra
    sha256 "0a5fc1202694a952c64577086177a9fb2ac381342beb19436377dcae0df13aa3" => :el_capitan
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
