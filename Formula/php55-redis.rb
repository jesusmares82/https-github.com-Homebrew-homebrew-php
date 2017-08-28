require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Redis < AbstractPhp55Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.3.tar.gz"
  sha256 "e415927538160628ba0eaf7ad72cc7f7752d29b46905dfdb21d627eb13c1d38f"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7aa429bf43ccaeaf51479a31ea31746eef7e74f202f3d380c6fd605a7b4bd941" => :sierra
    sha256 "f2df5d712516d1faa306e1f9c3a2e96b1013e857166c9a8fccc628c4925bc210" => :el_capitan
    sha256 "a88b3f848939dce05f033d070730f6ba98386714134de9127b73e46b254911bf" => :yosemite
  end

  depends_on "php55-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent

      ; phpredis can be used to store PHP sessions.
      ; To do this, uncomment and configure below
      ;session.save_handler = redis
      ;session.save_path = "tcp://host1:6379?weight=1, tcp://host2:6379?weight=2&timeout=2.5, tcp://host3:6379?weight=2"
    EOS
  end
end
