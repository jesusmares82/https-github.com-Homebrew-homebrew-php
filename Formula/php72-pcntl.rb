require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 3

  bottle do
    cellar :any_skip_relocation
    sha256 "42ee3bb8aff42faf44b72f4a991801c01aac1f323b065a1f83e3b3ca9d678049" => :sierra
    sha256 "9ec2a149e07ea52f002544b4a2d95791b291282338ed9dc704c533ef93e33bc9" => :el_capitan
    sha256 "822157b692f5ed21e3438712e81eb4ca76c799cee88e9339ce7fd99d8bd735e9" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
