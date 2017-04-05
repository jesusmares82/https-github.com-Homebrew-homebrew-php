require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.8.tgz"
  sha256 "38090c38f0d52dd0a4c41c4f7f7e4e4a86a6375b6c5009e754b19451212d0bdd"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "13e8e72dc495f0bde4d7a9e89e4a736b592d47760112b83ddc3e3e8562e685d5" => :sierra
    sha256 "eea7728f02a56df3b2931bb213b68dc84361ba8bc20b4b1f97ce420949146e82" => :el_capitan
    sha256 "a748e77f138dc77f045636c7cde0d3e4331d7c5b5e03885d4da1c11ccdd994d9" => :yosemite
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
