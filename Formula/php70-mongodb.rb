require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.8.tgz"
  sha256 "38090c38f0d52dd0a4c41c4f7f7e4e4a86a6375b6c5009e754b19451212d0bdd"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "3006a7c1019577d89c9e87a331650397e408b527ba4975fb7936149108d29dcc" => :sierra
    sha256 "10c1a2181666e52cef3a26cc200af2293ff9ff3fa300942ad5831fe7af5abacf" => :el_capitan
    sha256 "06365d4e2e7d081a983144a8fd1776f2c8d2717b680f6a12362c8f91abf248f2" => :yosemite
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
