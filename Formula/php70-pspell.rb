require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "41eff3f212ea92b61e40dbc342f23ac61e0e50d96cf7a68058667c822d3b192e" => :yosemite
    sha256 "66e321525cac6cf5adf5a53d99735fb734d32aad0ec474fc4d828269767127f6" => :mavericks
    sha256 "211aad42ef3b2da3ad8fb1d55e3b24b543ccb7b8f130399ab28b80c9e7e38e3c" => :mountain_lion
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


