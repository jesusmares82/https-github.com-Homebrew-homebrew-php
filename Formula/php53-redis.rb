require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redis < AbstractPhp53Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.8.tar.gz"
  sha256 "a7c6e2eef70bd8449bab819c8f01d951fcd86ce0417e03675445040236ed4dda"
  revision 1
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "87b786f325c1b2e8e14c20664dbef79a7601464226cd651c80bd3ec3edb62191" => :sierra
    sha256 "000e2c2ff23a17ac72f304f6bdc26fe059cd6b92525117f01d2493427b6fac49" => :el_capitan
    sha256 "6cbc36cd676616431b37a676f92fe383979fcb628463afc3af808c462f51d923" => :yosemite
  end

  depends_on "php53-igbinary"
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
