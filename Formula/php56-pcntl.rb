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
    revision 8
    sha256 "1b2132b0fcd4dde0cb4c5fd8149a8aec09e437d3051a1287aabdf253ec84dc2c" => :el_capitan
    sha256 "2dcd2a18b70d985c2c5dde9fd92a3604210cf4d109bbde010cbb512c1b7d3939" => :yosemite
    sha256 "363a039d1a20560bfecf9f241e7678993676afacbcd374e74c9cb7b78fbcdefa" => :mavericks
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



