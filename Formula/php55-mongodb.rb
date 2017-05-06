require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.9.tgz"
  sha256 "dac7f755001e454f41bd1ebf54a47754c524062d41244a75ea7ee3a9825a9d2b"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "14f89ec49df467e2f48a472a1ade370a6dda0ebc40f2d94c30839fc200086601" => :sierra
    sha256 "5077246edf71c02f24074e246ddd787e6aac0b1127b6ec7462b94d4fa486c226" => :el_capitan
    sha256 "a752db9547e8ed1981906d4d7b556d5c9aa1e37a789312f2de9dabfb7fd3667f" => :yosemite
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
