require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.5.tgz"
  sha256 "1d43c5038cd8cb7e6db57620c40f2cc6385bd538db002c60f61f44376d829848"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "5b770bdfade189e259b802565a2ec479b1b29333cbd8199152e34d9a1a4274b9" => :sierra
    sha256 "17f84b36980a41c77a3d14a6eacac6ab67ee835af27a4754b1b530c27f071539" => :el_capitan
    sha256 "231bee380c474dff3be9ee98aa727ddef6f123f254e1123a224b58d7a1cbb191" => :yosemite
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
