require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "2214232541da2a7009780a231fee715e28fa719d5f2ef9f7005662f5a5c6f7ed" => :el_capitan
    sha256 "c3ae4c0fc79a880feebe126ef804b25509bdb06399192b4e01011e90870f5c5e" => :yosemite
    sha256 "a38e2da60d7f158f5da6fd53f4f00dcc34393c7c6495c561081e94ce948e6a36" => :mavericks
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




