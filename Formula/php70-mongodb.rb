require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.3.tgz"
  sha256 "6c8f6b28ae69223df8f6c43ceef5776e60306910332c8f0c68d4096680a96a62"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "dfb8297864070a8a9c8976f1caceb865dbb8184d14f0c82d1d9faa420865a964" => :high_sierra
    sha256 "07216057d523cbfb9675f5a4f9de0b812ff180577f1713b841cac7ce91ddfe2f" => :sierra
    sha256 "2f22693b40656c69876d111136872a367b88cb82bde85ed7897b9b0afc2e4e0d" => :el_capitan
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
