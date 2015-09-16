require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  homepage "http://pecl.php.net/package/mongo"
  url "http://pecl.php.net/get/mongo-1.6.11.tgz"
  sha256 "cd180ae35f537a199d374a3105106ee5a2b0cab618b12f6221e4c985c28955ac"
  head "https://github.com/mongodb/mongo-php-driver.git"

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

  test do
    shell_output("php -m").include?("mongo")
  end
end
