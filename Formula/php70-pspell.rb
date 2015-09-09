require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "157465b3a9c57ce05cc05e2605a6aba535805a3f5733239832fb6ca7e88a4fd0" => :yosemite
    sha256 "95e21dd260352983c81ba1b517b725170b4bae2865c4be0f00ea6dc0d5eb4a92" => :mavericks
    sha256 "8842560c21aa57220d77837dfb3b9778c05c8f12de574987f5e3de42c1336fbe" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pspell")
  end
end
