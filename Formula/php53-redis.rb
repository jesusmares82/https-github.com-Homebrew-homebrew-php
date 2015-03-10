require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Redis < AbstractPhp53Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "16f2c2524a09b3997f525737490948b9f76afc1e75f7d08c20fb4fcdce45aac5" => :yosemite
    sha256 "a2b92fe7818c25c145cf750ca82aada339b1775101caa2ef7041a975eb5e1629" => :mavericks
    sha256 "28ebf08c9c28b75a289071a720a66de414e5c5207114f632ff10e307621e75e7" => :mountain_lion
  end

  option "with-igbinary", "Build with igbinary support"

  depends_on "php53-igbinary" if build.with? "igbinary"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-redis-igbinary" if build.with? "igbinary"

    safe_phpize

    if build.with? "igbinary"
      mkdir "ext/igbinary"
      cp Formula["php56-igbinary"].opt_prefix+"/include/igbinary.h", "ext/igbinary/igbinary.h"
    end

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("redis")
  end
end
