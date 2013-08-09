require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Jsmin < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/jsmin'
  url 'http://pecl.php.net/get/jsmin-0.1.0.tgz'
  sha1 '0cc709e7ef6728535905a3a7492bf2347244a30f'
  head 'https://github.com/sqmk/pecl-jsmin.git'

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file unless build.include? "without-config-file"
  end
end
