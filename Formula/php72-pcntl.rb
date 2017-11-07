require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 8

  bottle do
    cellar :any_skip_relocation
    sha256 "c37254a1d39d6279d8be1cd2684635d9a71594cda042569414acaff0f908a608" => :high_sierra
    sha256 "7c0106afda4b9df097355c245df3ca740169c288159b7fd4c1f93fc7f94edf8a" => :sierra
    sha256 "5f849381d1800dca2794f4f48eeb9eda5a0ad23eb58da210308ba231d418260d" => :el_capitan
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
