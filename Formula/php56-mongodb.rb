require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.6.tgz"
  sha256 "cd4bb7402911431098ef6c12562dca53a89808ed1ba9798131002be1c61c6b59"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "ccebe32eee9610052fe60c68508ea813fcf52e2c3ee8c84edf2a726617011636" => :el_capitan
    sha256 "53a4aa1597bb0e002e87ad552dbb5422139ed68561885decbabef6cd0c452108" => :yosemite
    sha256 "d1574945e3e091c0217cfd5b0f1f28929bdb360c9d5b045f3a8c1f3dc9b848ee" => :mavericks
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
