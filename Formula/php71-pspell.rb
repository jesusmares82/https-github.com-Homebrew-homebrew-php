require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 8

  bottle do
    sha256 "1e33abe8b1e12d5f84bd3c4fb2128cd236d40d8613e5042d6020dc7a5ebdb8c7" => :sierra
    sha256 "7c0f115b06a5f2b2cf6c00eb3168c21c3eb8f3d91362218f1ceec4ed5f009013" => :el_capitan
    sha256 "09cf66b4f64b76d7ae664b2d06506d331b85dae8412ccd016f96d7f9faa5faf9" => :yosemite
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
