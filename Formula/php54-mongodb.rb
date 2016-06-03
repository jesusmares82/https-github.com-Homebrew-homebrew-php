require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.7.tgz"
  sha256 "65bfb564d9a53a7642a02f07085bd9055b43522250649886ed65a37771cf9b49"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "3337607e5f91321425cecd44650be964d637b09926a6333f08bb20827a946b53" => :el_capitan
    sha256 "cf52cdfe0d483e67d5ac6b323374e3f75ba32067adfb72f170558dd2e70439a0" => :yosemite
    sha256 "e5f622f7365732ea9435ef1072c9e7015f3ef809db50c40e829c6784f5647dda" => :mavericks
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
