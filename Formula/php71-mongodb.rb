require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.9.tgz"
  sha256 "c4882991da323dfb0e60a43390a7a6cad27f632294f2becd44604dc9f7e90c3f"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    rebuild 2
    sha256 "383ee3090a3c4dd455a33a024c68be9a447795f4093345d6b897ac9dcba53eb9" => :sierra
    sha256 "5f75e528edced089b397044e7fbc2c7d38182e87026d3ce56852a938751a3391" => :el_capitan
    sha256 "7c7d23fe0c42f308803f407a34701dc44120921b8c1b115c897dc3af7b01568e" => :yosemite
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
