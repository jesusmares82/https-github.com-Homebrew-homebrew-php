require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "f0a85d443bb86f1e97ffc2c7603765cb2815c0880f2abbfeba0d8a9ddf085027" => :yosemite
    sha256 "0c35ef0aed26874339b8e9493401c3fe9cd468a243390d2f637356e739487e99" => :mavericks
    sha256 "34df610d90e98600206086a39d5f4d257acafbc37891340e2617831547338b73" => :mountain_lion
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
