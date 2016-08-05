require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    revision 1
    sha256 "a846b65bb9b275ac39811d13c055011110a1711ef1be9f7b225a6e9d662ef4f0" => :el_capitan
    sha256 "f8eaa6d0e34bfbc8d472bdaa4c253f44416b7802c9b069114df41cbd0c2a6666" => :yosemite
    sha256 "e3013cf897d07200b1fbc6f3947eabaaa34c9721f4e4293030e3cf56e1133081" => :mavericks
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.2.0alpha1.tgz"
    sha256 "03ac8a762949699aef0467ccdfbb8dfe70b57b0b57b740fe5041a4aff28685d7"
    version "1.2.0alpha1"
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
