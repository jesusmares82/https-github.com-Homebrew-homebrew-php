require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.1.tgz"
  sha256 "65fac1b91b175b2c8dc92bd5939058a1c50d241ef66b7a155a3c96600366f14c"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "028c2cf5e9baf18d4124a8ba14c649c6fbdfa9a6eefebcbe5cc9afd37b12608b" => :sierra
    sha256 "1926754087dca6a12c8f615aa6d344ba5588347d1a02cbc400b0f71d8e2ce7d1" => :el_capitan
    sha256 "7177a55c632685aa22121e3e296edce776e70b9b101706c809eeaae9d2be30a3" => :yosemite
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
