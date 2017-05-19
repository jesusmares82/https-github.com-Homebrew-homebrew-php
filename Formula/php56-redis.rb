require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz"
  sha256 "a060fcb7784b9323905cf58557d924a394bb539350bea28d02f910df8ddea1f6"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4d5431f54edbe5ccada0cabdee9523527410016fbac425fe61a7fed38ace989b" => :sierra
    sha256 "31d5c2a8fac94049c496be863b76863a4308e4e1832eeae3744b6179c54e4309" => :el_capitan
    sha256 "344c5c98a5ac4b16370d7256feb49aa3dc875f3ad45cbfa06557a47e0e6cc81a" => :yosemite
  end

  depends_on "php56-igbinary"
  depends_on "igbinary" => :build

  def install
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
