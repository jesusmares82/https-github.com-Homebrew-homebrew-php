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
    sha256 "26c167f8823dc896241252f9ca8f5b03a5a48151c3e1df83c162bbae4faa1a0b" => :sierra
    sha256 "9578ceb9b94dc9912905b03b438273b2d4507233aa3a25695eecb638c0aaa67c" => :el_capitan
    sha256 "d72168b2f1af934ab3e4bbfa51a2891bc1e984ea4f8c041d6e5f0ae5faefb1ae" => :yosemite
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
