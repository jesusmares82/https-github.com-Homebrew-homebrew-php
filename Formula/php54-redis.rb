require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz"
  sha256 "656cab2eb93bd30f30701c1280707c60e5736c5420212d5d547ebe0d3f4baf71"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "81916e219f46ebc5ddc31f3e4e80bba080c11fe24b3c003f5d8efa1dca182f5d" => :sierra
    sha256 "c0f610c1d43365c2ad7a353d38a2edc945fe5ae914ad36c08a48929b10cb5240" => :el_capitan
    sha256 "339add9f0814b1e39a6c717d4dd26bd5d4d6bb5260d6287fdf63db0626c6ac41" => :yosemite
  end

  depends_on "php54-igbinary"
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
