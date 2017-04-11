require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redis < AbstractPhp53Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.1.tar.gz"
  sha256 "78c577225daba3282c2968d7b29cb346b9626b2ed3dfddda02e26293e0931995"
  revision 1
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d61c52c5f1a54a9ae7bee0f58054def455c433d6f48bd861d5c7a6e8cec32b3d" => :sierra
    sha256 "7941ebccad8ac197de21e5ace9cd3e7fb62a56b984836e39e8050c22837a6554" => :el_capitan
    sha256 "bb9a3ca3e7d1ec18e7fdf8ad15adea7d2c9aa0973e7fbb78c64c1139b8988adf" => :yosemite
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
