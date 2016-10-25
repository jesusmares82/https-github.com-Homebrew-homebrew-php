require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.9.tgz"
  sha256 "c4882991da323dfb0e60a43390a7a6cad27f632294f2becd44604dc9f7e90c3f"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "2fda97635ff471d2f6a84c4ed35a15584ddd2bbb56ed6dce371bf102cbc8937d" => :sierra
    sha256 "b23e8544ce804614d1dd1a3c44b9a73f7db02f842eba0e015ac6c503c76f719c" => :el_capitan
    sha256 "a02882939b47a34b2e460d3208a184b0e2c649d150c3d5d91114a320906e4d72" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.2.0alpha3.tgz"
    sha256 "295ff6792e734c5d0352efb0f2bb0c1dad25114d5c48bd98004d7650d742de3f"
    version "1.2.0alpha3"
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
