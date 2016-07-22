require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 12
    sha256 "2f5b5d2eb4c3d4c1bd679fc0157d945d5fbaf8764d3798f4e4b5de7309b5eedd" => :el_capitan
    sha256 "479ef743e724478efec17bd946e06ba14483f08e75149e0d0bf97d0b88d20d0a" => :yosemite
    sha256 "d955249d9f098668bdb9a0778efbe78adf4e3ef9092f88655ece77445ac2f3e0" => :mavericks
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








