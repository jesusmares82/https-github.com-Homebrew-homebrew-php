require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Redis < AbstractPhp56Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.8.tar.gz"
  sha256 "a7c6e2eef70bd8449bab819c8f01d951fcd86ce0417e03675445040236ed4dda"
  revision 1
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "87b0ac0c33d2d0010aec2299d09388fb5613dc62a91208962579fe5846206124" => :sierra
    sha256 "9677bcc0c3e16483268841368b6339cc1f429924f38d7fd10a0088f4094f871d" => :el_capitan
    sha256 "521b5c16efc703815d599f1c7f4710234685d3994d3814fac6f6c0d4103c58d6" => :yosemite
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
