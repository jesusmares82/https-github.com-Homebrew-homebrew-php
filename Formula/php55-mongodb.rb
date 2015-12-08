require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.0.1.tgz"
  sha256 "d31b98f2f58fce4d8183197fd8415ad71d8569852b85540316567ab1f647b9a0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "0a87392b89e712d33ce263be774e7b8bd5cf5aed6e181b4712f8e36db45546ef" => :el_capitan
    sha256 "1d689ca9233421aff83971628ab564c6a9e796a405b24e92fa02de7df6343e6e" => :yosemite
    sha256 "ff7669b1a5099e1449c0cf9fb12b260cbde517604d9b3228b4ef9c3d759f1470" => :mavericks
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
