require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 4
    sha256 "cec71aedaa463c58986b1828f0987486448b017b79700ea9a5ebb3b5570900f4" => :el_capitan
    sha256 "881112b647d1ef4b6c4d08e9b48871d0540e57473e270f6692e220dd7b1cf3e7" => :yosemite
    sha256 "af78d4795cc867f501385ebed9d499f68e4c1c794e110416e7fd6921031a7e26" => :mavericks
  end

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
