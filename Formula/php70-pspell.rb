require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 14

  bottle do
    sha256 "f318eb31ab9a4e3b086a89d85f7f1f723182156020894ff7acba65b4d2d046f3" => :high_sierra
    sha256 "aa6f81aa77f125d31c471014ce83a7fc365dea8e000d514298afe5e7801a7625" => :sierra
    sha256 "78be289cef9ba3838f50048dad34656c0e445f245852871303c43fd74c74e5b6" => :el_capitan
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
