require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.2.tgz"
  sha256 "cbe02827653c3c03949ce96885e6be27b014322f642c89788510cdf3b5dbe3d4"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "5fe20e2160b06286758bcb362e5044dce56176feb28816c48d50da527cc00257" => :sierra
    sha256 "62c26de22b7455eb474dfcb1e7a4e9b62f8d8342871f07b6344db784769df451" => :el_capitan
    sha256 "90e7ef1e5edcb9defb2337d8f1ac5f21be77aac208efcf1083612f7cbd18e603" => :yosemite
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
