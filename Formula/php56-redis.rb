require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.3.tar.gz"
  sha256 "e415927538160628ba0eaf7ad72cc7f7752d29b46905dfdb21d627eb13c1d38f"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2c8a8498b195a425989f22db1a871c2accb962bd0dd2e6d9aae67bb20a8a3f07" => :sierra
    sha256 "d68329e11aa7af8af31e6bd02295f811424f0a9339ea1397ba3c67d937886475" => :el_capitan
    sha256 "1c3fc16dd4b94bcbfcc99b9bbfb86eb292f34b8898b5a881b79b071ec320f22b" => :yosemite
  end

  depends_on "php56-igbinary"
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
