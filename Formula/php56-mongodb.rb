require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.2.tgz"
  sha256 "cbe02827653c3c03949ce96885e6be27b014322f642c89788510cdf3b5dbe3d4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "2d1603fad97639d4be92a77042091f69e00c9b2573ddc846438690d205b08a25" => :sierra
    sha256 "b97b7159fc323e03f4302f7e8f0ae1175ef02b57b367059b8c76db9b3346cd3d" => :el_capitan
    sha256 "5ae332d82b9da90f35ab95eb467bca1a5b65ea0e658736a76d7519c2cd46ac43" => :yosemite
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
