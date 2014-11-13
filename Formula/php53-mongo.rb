require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.5.8.tgz'
  sha1 '768fa06a14d74fdde351f3757230d1f5660ef9c0'
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
