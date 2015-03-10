require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz"
  sha256 "a5882dd9b21908e123b3d5c5f72d6dc8cbbbb6a29996e568c4d18ed356c0362b"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "5977351adb25516589dfbdf41a56f6c3e370a68794d244cc670189e04c6f1654" => :yosemite
    sha256 "2f46f0030d2f7a638b70dbddb13dc17d93fc20ef05a3b29090aa3cf6c4569886" => :mavericks
    sha256 "7acdc7db3991953adf254ccc3d461bef56e2e3e13d9a253cc872894694ccbfd5" => :mountain_lion
  end

  option "with-igbinary", "Build with igbinary support"

  depends_on "php54-igbinary" if build.with? "igbinary"

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
