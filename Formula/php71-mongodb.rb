require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.2.tgz"
  sha256 "cbe02827653c3c03949ce96885e6be27b014322f642c89788510cdf3b5dbe3d4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "b0e23bd719578a6a17bf32a870d41eebc54483df79772f0334f6cbb82ff3a8a9" => :sierra
    sha256 "c9aec9fe306aac0d88f2f0fe25b946c22d5b75107803a95cc60432b893a3504f" => :el_capitan
    sha256 "b811089c0409b4f04a1fe6a494307fe17ff866ea8e6f15037188f8a2af939422" => :yosemite
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
