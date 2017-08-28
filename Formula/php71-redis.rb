require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Redis < AbstractPhp71Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.3.tar.gz"
  sha256 "e415927538160628ba0eaf7ad72cc7f7752d29b46905dfdb21d627eb13c1d38f"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe0cb05652f68edcd23e8641b562a13b93744f67b2e306f72c140ec09b890fb6" => :sierra
    sha256 "7cf388a33b9db9a75f5c36c1ccee42e432b43ccc53d0e60f0dca31e56921bd7d" => :el_capitan
    sha256 "db13e914358c8bc1d67b6ee7bfa08c4c9242342d32bad25713e1d0f52e59a035" => :yosemite
  end

  depends_on "php71-igbinary"
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
