require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Jsmin < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/jsmin'
  url 'http://pecl.php.net/get/jsmin-0.1.1.tgz'
  sha1 'b1abfb443ce5df80866fc9350a792f3be814f568'
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
