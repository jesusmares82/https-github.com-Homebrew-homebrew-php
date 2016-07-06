require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "57e0a4fb94a62e3bd2804654128f290900bab1635357e8cdd11fa55a690ac98c" => :el_capitan
    sha256 "c15328f82ca08d12d43cb1fcc132267f3564bb37a9f0fb64ed06e24a7c94aa67" => :yosemite
    sha256 "686e5f7329708ca00fad6e8ce5ca036afc707d2d82d53e37e661be89abf6a7c9" => :mavericks
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
