require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "165bf4beb4b4bce9e8e3c3fe9df7f877e0bc2ecfa381d537ef9240b6c34aeb8e" => :high_sierra
    sha256 "bad3b304fa4b9735d41f9ef6ca1f9074c6e62e92076651b380e65892a9e8b76e" => :sierra
    sha256 "5a7ebe978e7edde595922c854823dbd8006ac4f0650ef5eb8919c8b17d711221" => :el_capitan
  end

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=darwin"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
