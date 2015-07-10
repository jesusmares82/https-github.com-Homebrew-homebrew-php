require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "d5a9077bdb1c9e7f9c1d8a5ffa59ff92d651d652935937006e8a7238f8d31165" => :yosemite
    sha256 "af59de9896e0b0e2e8db236ad1de7e6dc96ae584bfe1eb448aa0d6c0049f6152" => :mavericks
    sha256 "e3df8e7747bf26911271560cf704ef04cff9ac80bcda54bef063a08dd828b9ec" => :mountain_lion
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
