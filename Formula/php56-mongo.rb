require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Mongo < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.4.5.tgz'
  sha1 'd9608822a3267f24748e9bdef5850e112f0ef54a'
  head 'https://github.com/mongodb/mongo-php-driver.git'

  def install
    Dir.chdir "mongo-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file unless build.include? "without-config-file"
  end
end
