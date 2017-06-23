require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "df60e284a9437d5ff9eb232ded4baee7e975ce094fb805ba4117f485811aa8b7" => :sierra
    sha256 "ce280caf1063b9e15f11b7fceda90095194febd0bf616b78d01af844c08af058" => :el_capitan
    sha256 "6900944ea7ba7a03012b65da4e523dc6eb8d6c6491091869c2aa40348a3e6955" => :yosemite
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
