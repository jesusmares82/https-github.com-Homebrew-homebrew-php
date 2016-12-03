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
    sha256 "50cdc1624b81ab3d9b6f3ce4340763adbeabd8ec5f664da4dfdbed3f6a6bfb1f" => :sierra
    sha256 "6b38c0aa34d265546dc64e9d3a790b63294c4b4f047afd582c0fcede3cd8781f" => :el_capitan
    sha256 "0ba02eb73bf793817041ae7432ea94a809ca8f08a7dd27369c8b8f53988b20d8" => :yosemite
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
