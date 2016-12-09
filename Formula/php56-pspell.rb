require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "24f445b5025fb3256476465afcbfcb293894392c2e7db863b9fba557d5381a86" => :sierra
    sha256 "d6ec298c30fd87c2fec66415ece45e47fbb7fc13b898515ee7b9e7bdc7f5199b" => :el_capitan
    sha256 "9379c2ef86baecfd9ea23c38ef635211c1ff41892b087ee13d0685ccbd074c01" => :yosemite
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
