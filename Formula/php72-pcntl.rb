require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 8

  bottle do
    cellar :any_skip_relocation
    sha256 "7ec74e99ec28e579acca8bb90c6b80e8aa1c48f2ba00649deaad09523c9fd101" => :high_sierra
    sha256 "74f5bfdac94e9be93c87ff6252f7dc2adf6141385f2c1b965d29ef43d176443c" => :sierra
    sha256 "bd3b0dd68a06a896b8b761a88ce39df3342fd2483cb5074030f980d0448a9dde" => :el_capitan
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
