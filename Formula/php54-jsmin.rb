require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Jsmin < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/jsmin'
  url 'http://pecl.php.net/get/jsmin-1.1.0.tgz'
  sha1 'e081d7c66a9401b9cd8b0ad585f357a4d7e335ef'
  head 'https://github.com/sqmk/pecl-jsmin.git'

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
