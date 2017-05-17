require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redis < AbstractPhp53Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz"
  sha256 "a060fcb7784b9323905cf58557d924a394bb539350bea28d02f910df8ddea1f6"
  revision 3
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce2de81b208e9b3fa5280ae25d019582a368b0996162b0593a2ac76da92d9fe1" => :sierra
    sha256 "b7084eb39f204520195b8e56b3bbed0ef637b040882e34ad58cbc699da6b9831" => :el_capitan
    sha256 "91e8e50e11769c1dc4eb003688d5be39a985d6ae4576b424910b22df1e8db4ca" => :yosemite
  end

  depends_on "php53-igbinary"
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
