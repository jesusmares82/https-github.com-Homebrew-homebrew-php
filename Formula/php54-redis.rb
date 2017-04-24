require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.1.tar.gz"
  sha256 "78c577225daba3282c2968d7b29cb346b9626b2ed3dfddda02e26293e0931995"
  revision 2
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8738cf2fd64c877a49255993cdd112b318bafd5657d96178840daf4f9fecd6cf" => :sierra
    sha256 "dae82e8a3929100261f80d391751855223304647f6e9dff010e1595a807ce7d9" => :el_capitan
    sha256 "a6aa7d8a4a3e0f2235283fc228c72c4edeb234f2211b15bc16ee25ef948f6444" => :yosemite
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
