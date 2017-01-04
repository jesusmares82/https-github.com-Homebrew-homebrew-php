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
    sha256 "79f4538821ef96fd64168b7b4cb7d8358c373d2179ba779f6c263f3213bf4bfb" => :sierra
    sha256 "14c4d00fd41837dd25a8600cbf21fd121817b3fd5a1ed45a820527886705e16f" => :el_capitan
    sha256 "550d15d135bc5a75764ccdfb8a155a5a6e6af8497fbc4161d3c694f72a38959b" => :yosemite
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
