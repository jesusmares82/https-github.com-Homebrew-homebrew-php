require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.0.tgz"
  sha256 "72630b038c7b57631a1d3931bcc1cb237fe79a25498b56ad65cc536d1bb0aed4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e3714d60cadc854d9f1ed52523785e21248122b08f8457d527e570a48f4c84c4" => :sierra
    sha256 "3f797ce58482c2cd054f4784cb83b1b74077a0f9ea7dd4b68488e02e53442350" => :el_capitan
    sha256 "80b3660a9d2d3a9ff5521d5c66f639d8922f55ecc7c78bdcf0ac12815bb354ba" => :yosemite
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
