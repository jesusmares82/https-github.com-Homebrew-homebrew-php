require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Redis < AbstractPhp70Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.2.tar.gz"
  sha256 "a060fcb7784b9323905cf58557d924a394bb539350bea28d02f910df8ddea1f6"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fbe58c3647f0c2b04b5db2fb3242ff73bb2598bc449a3df5d499b426e886bdb9" => :sierra
    sha256 "e628da9d97fde10782289fc255eee02f4026dae4e8439388a31d01bc7b61564f" => :el_capitan
    sha256 "bcf300a15dce9abc1d8a44b8389466311585ac54010777e51ac3ef5c4b4d1ec9" => :yosemite
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
