require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.8.tgz"
  sha256 "38090c38f0d52dd0a4c41c4f7f7e4e4a86a6375b6c5009e754b19451212d0bdd"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "7b2405fbf90d7299b6f3f372d25d3c544dec518b7f83a05da29b7bfcfa368adb" => :sierra
    sha256 "a7800bde464c14ed8518afc25e539ee37b4d51457703709d7db57598d2810a79" => :el_capitan
    sha256 "84fbc353c6495df4f0587e8076cf3a2fae39658edb0682d6735fd47d3acf5278" => :yosemite
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
