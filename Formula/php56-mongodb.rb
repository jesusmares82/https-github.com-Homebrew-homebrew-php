require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.4.tgz"
  sha256 "c78190115c0d51a440d66c75b6c12192f6d97873d141b34c5c2406a816fe1bb2"
  head "https://github.com/mongodb/mongo-php-driver.git"

  devel do
    url "https://pecl.php.net/get/mongodb-1.4.0beta1.tgz"
    sha256 "427185ef5a668ccb79dcdbbd853b74664cee8fe0fbb9ce241ebc5919e36c3ac7"
  end

  bottle do
    sha256 "30868d9c30e3c148d5f1b909972b3bf24ecc190e1cb375ee207c9a84f9eca883" => :high_sierra
    sha256 "9ebfc0aad51716e2eb5e9aea3f027e175a178b2a9eade74406054307d69229a2" => :sierra
    sha256 "a5651ebc9aedf6cf306105fcfa872d3ea999ef967b03e0053e7f936c7f0a904b" => :el_capitan
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
