require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    cellar :any_skip_relocation
    sha256 "021d1b92ca4aa6c77fd71fd2011f145ccba7a29796a4efddaa0c6dbdb39d3b6a" => :sierra
    sha256 "33cabb068828b94aff630ff6e92a0dac75923f155f5ea5f8c0d8515a15a03344" => :el_capitan
    sha256 "d9b2a66fd05e1f0a1d4445754a727ac3f5b858f0ef634c70b6331a890112010e" => :yosemite
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
