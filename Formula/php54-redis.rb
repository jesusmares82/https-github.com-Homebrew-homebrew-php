require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz"
  sha256 "a060fcb7784b9323905cf58557d924a394bb539350bea28d02f910df8ddea1f6"
  revision 3
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "324ca9e5d67d8d58c3a718b3fe995bf0231875a3989a375d2b1185ac8bff3fc5" => :sierra
    sha256 "59950c15ad7281aec9bb814ecf90b2b46f389aa2f683b2faebad03c4a41a1778" => :el_capitan
    sha256 "37825139b4464d093ecf47049cebc7c2ea085f547e5e7d5b5b72f0f289b105b4" => :yosemite
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
