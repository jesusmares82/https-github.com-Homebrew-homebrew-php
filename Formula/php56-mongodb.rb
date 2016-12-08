require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.1.tgz"
  sha256 "65fac1b91b175b2c8dc92bd5939058a1c50d241ef66b7a155a3c96600366f14c"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "8348dc85786eb3790f6fd3f8175a63d8f1688e48e5a05fc3ba00144621fe8695" => :sierra
    sha256 "72a047dc00d512fe1156402729bb2a353424cff77444c50429dce540183d1dd9" => :el_capitan
    sha256 "c70c9bc6d0cd074af7d5624eda4b1f919463f7f963eef1661a4d2c57bd2b70e0" => :yosemite
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
