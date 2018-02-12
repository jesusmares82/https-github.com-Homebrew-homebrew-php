require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "6c4613d8d81cf1f423654e01f0376dd2294bf5e36f186da5ac570eadc3d2531a" => :high_sierra
    sha256 "8ec0359d4161b55524a95ea9f128b35a050c57a5398ef9f2a78baacee60546be" => :sierra
    sha256 "33e91cfcf2dfd7a5e441614eb6c29b1600211f577ec8b54749368679b0d216ac" => :el_capitan
  end

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=darwin"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
