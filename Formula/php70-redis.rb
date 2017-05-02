require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Redis < AbstractPhp70Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.1.tar.gz"
  sha256 "78c577225daba3282c2968d7b29cb346b9626b2ed3dfddda02e26293e0931995"
  revision 2
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ccd88efb1375fdc2fc137336de99025177068adb669338b03b6a71fc1b52e35a" => :sierra
    sha256 "2256f16dabcf509055bfc8cf5c1b1750e78144ac05050da5fdbdcfc745139188" => :el_capitan
    sha256 "a04e5dad9b30c217a6878d192b15c135cf4fd50b2241ce318472305308bb8e83" => :yosemite
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
