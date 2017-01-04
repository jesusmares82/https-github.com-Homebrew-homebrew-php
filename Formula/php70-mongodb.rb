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
    sha256 "c145d2cbc41b84b3ca4474b90bc01e3247f3e60255c1f78bf99538cc9475c7f9" => :sierra
    sha256 "f95f58c88ec2cdc96f08cfdaa591e5664cf96f6dd00660101ceaeae488f62bf7" => :el_capitan
    sha256 "384050d193bee9c224df06577fb21a3d4166d78a7a1d3871c1d7711de7dcb333" => :yosemite
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
