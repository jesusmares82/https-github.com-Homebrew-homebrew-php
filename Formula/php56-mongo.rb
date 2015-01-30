require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongo < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.6.0.tgz'
  sha1 '3c5e4f595793a11e1542266f8f71936563a13850'
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
