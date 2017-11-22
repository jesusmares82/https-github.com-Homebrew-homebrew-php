require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.3.tgz"
  sha256 "6c8f6b28ae69223df8f6c43ceef5776e60306910332c8f0c68d4096680a96a62"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "4bf978fa78cfd7e7bade17617d5a34457ae0492c515bb61ff8994bdd86b54067" => :high_sierra
    sha256 "920a8b35b1eee199b4f7e102f8f33d4249bc183e13f3b4eca1d8c8f09b7af139" => :sierra
    sha256 "fa881f70d7aa4c4ee258c90816ceccbf34539189b7d5aa530df23a8fb04999b9" => :el_capitan
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
