require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "1cbd4e8dd23222e174179e49897cfe3c6d5d1895feb79ddb6edee59ce6b1029b" => :yosemite
    sha256 "191a63c01295b254d4510f39f3e65b6b34e07218e40eafa5d88dae62b83d8351" => :mavericks
    sha256 "0fea8d101e079f69ef1443410487fd8aa77db9c6f4f4cdf4de6732587d892fe2" => :mountain_lion
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
