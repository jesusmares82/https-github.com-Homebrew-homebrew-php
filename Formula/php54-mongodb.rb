require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.5.tgz"
  sha256 "b3b9acec35663b0665d01f786e4d9b90a32c0e361d8b296527f1d7b2e4028bee"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "6461abc67d64a8a9b438b89c5c92128f767d762afa874576a845fb6d9eed9a97" => :el_capitan
    sha256 "b06441fd44988628f233ffbcdf7bfb8129b716337608e3652e264f8f12fe9883" => :yosemite
    sha256 "7a39154b64ecc0840b28629c7dfecfb381807dd9b72a46536adc29447d5ff84d" => :mavericks
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
