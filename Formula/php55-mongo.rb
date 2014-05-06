require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Mongo < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.5.2.tgz'
  sha1 '27dade820e336a50d0e18b7a680c966ccf291efe'
  head 'https://github.com/mongodb/mongo-php-driver.git'

  def install
    Dir.chdir "mongo-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file if build.with? "config-file"
  end
end
