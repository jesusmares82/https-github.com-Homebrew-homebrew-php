require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pcntl < AbstractPhp54Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "0cb9e1032f76c97a6be6027e669d0bd1f6eaefa237ce37764f5ece5a0ea545fe" => :yosemite
    sha256 "353e6855517c2bb32e41b161042796b5d0e1b234c9946de263774973af30787b" => :mavericks
    sha256 "ae0fe2ad69072a44ccfc183c89c82f0974350a1707325559d696178f9760f446" => :mountain_lion
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
