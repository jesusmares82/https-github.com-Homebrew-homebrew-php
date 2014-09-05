require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.5.4.tgz'
  sha1 'd4d34c7450630726a44c1fd3d4fc4c5a8d738f25'
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
