require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 6

  bottle do
    cellar :any_skip_relocation
    sha256 "bea82252e2c33703af27355f76f5f450d4305e044cd667b65334061f2671c835" => :high_sierra
    sha256 "058957db4b8c23a1e601339cb9121107814eb80d19acc55c283339dff0a6acae" => :sierra
    sha256 "54e503a439034bf1e6499ad353bf776e49d986f95461861f7650c778510e5fda" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
