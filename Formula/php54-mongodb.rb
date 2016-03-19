require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.5.tgz"
  sha256 "b3b9acec35663b0665d01f786e4d9b90a32c0e361d8b296527f1d7b2e4028bee"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "eda376739c3d0f04c5920c971991f5c486e40a03df3968fa18e63ead060fc5a1" => :el_capitan
    sha256 "132d756fa125d9acd6c6398d64bc2107afd3b399813a910a9124252b82a4d0e7" => :yosemite
    sha256 "562200c4ac64da58e36499924ccb7710861324df5f0f2ed77e6a5491b48f06ca" => :mavericks
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
