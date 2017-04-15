require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 9

  bottle do
    sha256 "e6960326357f914d7e791e49f7b55d1e1a8f8b680099f80f33b6a680b01cad1d" => :sierra
    sha256 "c845655486c7a7c6011d37fda14df07a3376b9cb28fe2c254c34009159006875" => :el_capitan
    sha256 "6bfc08e3fd8ab6dfd4daa9fe779303b5937e485f8de028dbdf978b846abe091e" => :yosemite
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
