require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Jsmin < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha1 "e081d7c66a9401b9cd8b0ad585f357a4d7e335ef"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    sha1 "6b2c63b73c486b9e1d3f2165498a0e897da9fd4a" => :yosemite
    sha1 "f5de153627229dec97dcd3df695f2514fa3942f1" => :mountain_lion
  end

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file if build.with? "config-file"
  end
end
