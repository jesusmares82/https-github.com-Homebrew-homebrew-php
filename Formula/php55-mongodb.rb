require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.2.tgz"
  sha256 "3a24f60c1bfd68736977e53f40cd5b50eccf42472277ce8101ca7eea0fe82788"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "77cf4762d5b3569a646145820e8f1ffc74019094fb39896aae23c149f1524a6a" => :high_sierra
    sha256 "1bc7ce5f457e66d0057bc607436251d63299b96a32aaa102a24ba8df5b72b7b9" => :sierra
    sha256 "61dde9f0aad2600eb73eddc44d37ea69cd903c97702f90eb7f385bf7599340b0" => :el_capitan
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
