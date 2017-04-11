require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.1.tar.gz"
  sha256 "78c577225daba3282c2968d7b29cb346b9626b2ed3dfddda02e26293e0931995"
  revision 1
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "51c580528ee0ebdf59675050acb4fb2f095ec9b15dc9118fcc12f7a7c93bb7f7" => :sierra
    sha256 "301b99621336113207a97398d63207025353ecbe1315147ad8b9f662a20c97b7" => :el_capitan
    sha256 "33d3df71a1e4f8209ec32e836686cddb836a105bb381d39fd17020c280f1602f" => :yosemite
  end

  depends_on "php56-igbinary"
  depends_on "igbinary" => :build

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary"

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    safe_phpize

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
