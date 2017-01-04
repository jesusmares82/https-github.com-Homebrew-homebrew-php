require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.2.tgz"
  sha256 "cbe02827653c3c03949ce96885e6be27b014322f642c89788510cdf3b5dbe3d4"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "c7b4a053b1dce6132c08e0370feea2f9d8e713c58abb43e4cdd2d9e8a477cffc" => :sierra
    sha256 "dbd14a4018fbdc0c213bf83a66e16918d22cf5ba7e917cc8bab2a76bd125837e" => :el_capitan
    sha256 "ff85ba157d81d6f8bf78af001bc9f98fffc0cbe456305f8019c1b03249bdf0d7" => :yosemite
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
