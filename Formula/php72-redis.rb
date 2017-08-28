require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Redis < AbstractPhp72Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.3.tar.gz"
  sha256 "e415927538160628ba0eaf7ad72cc7f7752d29b46905dfdb21d627eb13c1d38f"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ebdddf307c47d5d548badcb6015c445af891efddb918c4ae4974ca5d2fc93e75" => :sierra
    sha256 "31ea06b20465e3aaa1521c08274604a68fefa921d560b98d3454446b6c7a5bfe" => :el_capitan
    sha256 "ca0fa42fbc743ce8f5fd66e8824a1d266e376232bcdc3d4e4794a0a10354c413" => :yosemite
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
