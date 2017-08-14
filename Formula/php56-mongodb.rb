require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.9.tgz"
  sha256 "dac7f755001e454f41bd1ebf54a47754c524062d41244a75ea7ee3a9825a9d2b"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    rebuild 1
    sha256 "26964300c570d5540eecd51eb2a571e2c114c457a8be1c004e4b45050274da5d" => :sierra
    sha256 "7f9f382a5ba0e7312292d5ee92d82d54964b51320d37dbc68ad95286da2cecbf" => :el_capitan
    sha256 "cdb94f1bbfd12dd4c67b29b9a75bd05ed272d2e4632eb9e292f6e0b6e3152774" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.3.0beta1.tgz"
    sha256 "bd93a9cd6b5c10158bfced6b11366bf56e8f822bf39dbcf0b15603f2328479c5"
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
