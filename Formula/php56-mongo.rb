require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongo < AbstractPhp56Extension
  init
  homepage "http://pecl.php.net/package/mongo"
  url "http://pecl.php.net/get/mongo-1.6.11.tgz"
  sha256 "cd180ae35f537a199d374a3105106ee5a2b0cab618b12f6221e4c985c28955ac"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d4857836fff0d1920150d2a6cb6f5aa2cd0eb23f480e4c14ecc891297dea0952" => :el_capitan
    sha256 "bae04a3a0942aa58900589676f8d0ee0c1b4edb00fb91fb32812295016090ddd" => :yosemite
    sha256 "fefb27c7c684d8dd642c19eadbae6710aff3511d02f70a87f85c0df313edb87f" => :mavericks
  end

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
