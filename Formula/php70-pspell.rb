require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 14

  bottle do
    sha256 "dda5d30c747faba03aaeaa2cbd579288ae7e4d276e7442e5d8b8bb71b77e3201" => :sierra
    sha256 "3a5807e3cfbee9c2a5516d72832d846da07fc98fd45d9f1ab3e8a2e07f8f81c9" => :el_capitan
    sha256 "ae873d9863cb040567ef4efe8a8bc1218113a3c448f444b4ba83122b7c9cded9" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

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
