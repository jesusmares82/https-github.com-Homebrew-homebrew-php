require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Redis < AbstractPhp72Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.3.tar.gz"
  sha256 "e415927538160628ba0eaf7ad72cc7f7752d29b46905dfdb21d627eb13c1d38f"
  head "https://github.com/phpredis/phpredis.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "7967df9fa3d6facf48e9e83457e7c97c8ae34c027bd0300b44db8a39c5daf363" => :sierra
    sha256 "2b435f62a79639820f5f5605187444e978137dbeda649a4b96bf7ce164f5bfc0" => :el_capitan
    sha256 "75882c609f0a464526eb68010a975ad03df0a600988113fa1692c6569e42350d" => :yosemite
  end

  depends_on "php72-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", "--prefix=#{prefix}", phpconfig, *args
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
