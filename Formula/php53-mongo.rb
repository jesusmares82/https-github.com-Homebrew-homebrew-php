require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.11.tgz"
  sha256 "cd180ae35f537a199d374a3105106ee5a2b0cab618b12f6221e4c985c28955ac"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f86961685e39b5943a867f7212812afcf079086250b6340b88fd4baea1f5a70b" => :el_capitan
    sha256 "796982addc04cc4f20869f81673bd09d50d3756dd806a5fb4ddc007178cce248" => :yosemite
    sha256 "fea51e130b0aebc550c4a8e3f130bffe56983cd7683f0dd4d1ef856d59146045" => :mavericks
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
