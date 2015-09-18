require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Jsmin < AbstractPhp53Extension
  init
  homepage 'https://pecl.php.net/package/jsmin'
  url 'https://pecl.php.net/get/jsmin-1.1.0.tgz'
  sha1 'e081d7c66a9401b9cd8b0ad585f357a4d7e335ef'
  head 'https://github.com/sqmk/pecl-jsmin.git'

  bottle do
    sha1 "30774416e0e1edb36e5220566363d83d6b89ec91" => :yosemite
    sha1 "7ef79b897b3c1db54a838e46d03ee1745fcb475e" => :mavericks
    sha1 "3b0f1882d2b4ffd0437cccced6bbd1cddde56194" => :mountain_lion
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
