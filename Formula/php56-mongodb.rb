require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.2.tgz"
  sha256 "4cb80002dfb6be0805457ef0c9f4e91fd03c2e54baedac958ad1e498c741484d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "361447f8d9871281df7d59166cd825b8e3334880b2b477b59d947919f0bbc887" => :el_capitan
    sha256 "264e746b1d942c71eacc67da13e742c358a98b523635049bb61ae922f4c1e689" => :yosemite
    sha256 "a134d2816714ed8bc9876f66901f26a3788f87de865a3591612f427149e45373" => :mavericks
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
