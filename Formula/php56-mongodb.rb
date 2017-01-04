require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.2.tgz"
  sha256 "cbe02827653c3c03949ce96885e6be27b014322f642c89788510cdf3b5dbe3d4"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "38dbf4fb11b6a2244e2ca4835724aacc3d7a7efe33fffd6a40e00c2d90490fc6" => :sierra
    sha256 "d74931ef877b2bbd659a70e300a21fd13988613d365fac9296f46253578f5129" => :el_capitan
    sha256 "49ff7f10d51388d48fd02be40bb78e6843a3ac586090f7c77a02df0a322c870f" => :yosemite
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
