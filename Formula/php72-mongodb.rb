require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.9.tgz"
  sha256 "dac7f755001e454f41bd1ebf54a47754c524062d41244a75ea7ee3a9825a9d2b"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "868bd2b7fe72fc77ab46a493615633894c2e8d2fbd7bd656d51e3bed7548c6fb" => :sierra
    sha256 "f6f1ef98cf2092da01944179c504653567d93c63d19dbe9fb9139fb96c6c52f5" => :el_capitan
    sha256 "2bb0388a3a53205418f3bf9c7725c9d3f8a913b4c4df599cacbde7e241731c88" => :yosemite
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
