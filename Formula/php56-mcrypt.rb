require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "12370cf1f6f28e72477eb9e720daa9e8ab4fd09437439aabba154ddd8514924c" => :yosemite
    sha256 "e3d8bd88bf723e786f265fa0df45c74fa9d37ed85ebc160b658f69c0c3411706" => :mavericks
    sha256 "800e108dce3c0ce84adea72833104fb74e293b8f95cfc52b86da75a376ec6dfc" => :mountain_lion
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
