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
    revision 6
    sha256 "d5b3b375016a691bc8a6cdf1e153f3fe7080ab2f3ddf0bcc5cd147897aef3392" => :el_capitan
    sha256 "7057ba47276136ac7a663420b1df9276f937c8057464c9e38ae63b4d2af50a3c" => :yosemite
    sha256 "3a7c51f70022696d6f41af42d278811773d23a9834d44addbaab209cc724ce1a" => :mavericks
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

