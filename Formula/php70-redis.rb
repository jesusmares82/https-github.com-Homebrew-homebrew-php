require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Redis < AbstractPhp70Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.1.tar.gz"
  sha256 "78c577225daba3282c2968d7b29cb346b9626b2ed3dfddda02e26293e0931995"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0dec166c8fd9b305a3a62ef73ec4c07d793b782db488c40a78bbba3d8bb4db3c" => :sierra
    sha256 "502d75488ab413b6739d7a0a0888e6d2e8d805722dd8f16df745d644988478ae" => :el_capitan
    sha256 "1cd95c42e6e34a23749308d7a0725b04337d7078362c10c28f92637679434e29" => :yosemite
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
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
