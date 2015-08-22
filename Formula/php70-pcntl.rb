require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    sha256 "dff7dd2c6058daccebb44d742cf7b32db57b1fb8d0a5b81af00a86d29fce19e5" => :yosemite
    sha256 "42238564fa85e9720a6d170c6ebe5bc0126fa5aff450e2db7fb93fd799c5d693" => :mavericks
    sha256 "af071f3b63f34b06acb3f077b3e3be34b4f1ba19edad6d4c7640c1fcc08b189b" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pcntl")
  end
end


