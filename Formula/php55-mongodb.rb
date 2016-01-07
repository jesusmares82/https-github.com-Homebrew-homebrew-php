require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.2.tgz"
  sha256 "4cb80002dfb6be0805457ef0c9f4e91fd03c2e54baedac958ad1e498c741484d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "b04b76ef1c28c20d9f36443932989dbbb6c6b1fba1bad7a1d32319e16f554c7c" => :el_capitan
    sha256 "ef1fe46262d18deffd3655be59fd919784386fa26884f65cf4062799ab6e7605" => :yosemite
    sha256 "5824a8e575d1d2f63f1c8ddc9d3af803cbc8e31c2a9e4961ba79a924febc0da3" => :mavericks
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
