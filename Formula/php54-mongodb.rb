require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.0.tgz"
  sha256 "72630b038c7b57631a1d3931bcc1cb237fe79a25498b56ad65cc536d1bb0aed4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "2fda97635ff471d2f6a84c4ed35a15584ddd2bbb56ed6dce371bf102cbc8937d" => :sierra
    sha256 "b23e8544ce804614d1dd1a3c44b9a73f7db02f842eba0e015ac6c503c76f719c" => :el_capitan
    sha256 "a02882939b47a34b2e460d3208a184b0e2c649d150c3d5d91114a320906e4d72" => :yosemite
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
