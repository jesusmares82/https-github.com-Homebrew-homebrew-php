require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Jsmin < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/jsmin'
  url 'https://pecl.php.net/get/jsmin-1.1.0.tgz'
  sha1 'e081d7c66a9401b9cd8b0ad585f357a4d7e335ef'
  head 'https://github.com/sqmk/pecl-jsmin.git'

  bottle do
    sha1 "260710b687ea64b79261664e4270f3ad1f4fab00" => :yosemite
    sha1 "57aad90eca916479b7aab08c2d156e3b3500839e" => :mavericks
    sha1 "90216a5363bcedfe27e932ac5e797fc1863abb51" => :mountain_lion
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
