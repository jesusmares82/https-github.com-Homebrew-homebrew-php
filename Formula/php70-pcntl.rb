require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 18

  bottle do
    cellar :any_skip_relocation
    sha256 "69bba64017db4bbc117afe30d0ffed85637c58bcfe5165195042f54e655dd949" => :high_sierra
    sha256 "1c2543bff54025548e20fdff9f000eb76d6c63f5607da793b25c268c57958a33" => :sierra
    sha256 "b727d308fd030e93caa229870a100399998b4238eb1296495ad60a0da2096494" => :el_capitan
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
