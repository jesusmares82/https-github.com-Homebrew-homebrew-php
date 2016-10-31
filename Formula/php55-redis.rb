require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Redis < AbstractPhp55Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.8.tar.gz"
  sha256 "a7c6e2eef70bd8449bab819c8f01d951fcd86ce0417e03675445040236ed4dda"
  revision 1
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "45ff6a0965fad42273d3700fea941d4ec6eba92acdfef6e3c4c7fd8498f5a6ee" => :sierra
    sha256 "1463397a357311d6650dc6cddab934f0f48dccc13c488fab16b963061ec47a4a" => :el_capitan
    sha256 "9d95af58c747c4f183831b07ec1aad667170c724516c4f8e69ca0d68c41447d6" => :yosemite
  end

  depends_on "php55-igbinary"
  depends_on "igbinary" => :build

  def install
    ENV.universal_binary if build.universal?

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
