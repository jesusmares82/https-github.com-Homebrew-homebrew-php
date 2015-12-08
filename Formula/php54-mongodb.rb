require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.0.1.tgz"
  sha256 "d31b98f2f58fce4d8183197fd8415ad71d8569852b85540316567ab1f647b9a0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "08598cb62515988e3a15e23d5f974438a9d370e98b8b294d6ac3ded9a5b4c5cd" => :el_capitan
    sha256 "1678da5f18758274d5f33e3cee611713ff1323d364f57ff0eac34d8610ef4952" => :yosemite
    sha256 "9cfd5a5ef6e6ea21ebb0feec06ddd0093b145302a312734501504294376f1500" => :mavericks
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
