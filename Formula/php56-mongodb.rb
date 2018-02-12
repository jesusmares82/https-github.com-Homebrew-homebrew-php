require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "30868d9c30e3c148d5f1b909972b3bf24ecc190e1cb375ee207c9a84f9eca883" => :high_sierra
    sha256 "9ebfc0aad51716e2eb5e9aea3f027e175a178b2a9eade74406054307d69229a2" => :sierra
    sha256 "a5651ebc9aedf6cf306105fcfa872d3ea999ef967b03e0053e7f936c7f0a904b" => :el_capitan
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
