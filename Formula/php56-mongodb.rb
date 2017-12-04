require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.4.tgz"
  sha256 "c78190115c0d51a440d66c75b6c12192f6d97873d141b34c5c2406a816fe1bb2"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "4c77a998cf9283ce1cf9e657668402d57aeec06626c3337d02cc693ad35b41cf" => :high_sierra
    sha256 "e97454dcca6e219c74882bb6a3a11eb3882acb2fa058c9a4f1bb6eb53863fb51" => :sierra
    sha256 "76c686d2b051cb2b7cb425890c894f43a8c6c214129685829f5c056346096268" => :el_capitan
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
