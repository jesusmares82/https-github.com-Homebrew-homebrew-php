require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.6.tgz"
  sha256 "cd4bb7402911431098ef6c12562dca53a89808ed1ba9798131002be1c61c6b59"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e8281960d20459457175f3f140eb849e381679091c9ce50fea63d7aaafa12420" => :el_capitan
    sha256 "08663c98ecfbd5946f2711c0fe6030ca86b74d8f015a118648e75332a5c82c29" => :yosemite
    sha256 "5a1fed5fd0f8addf50e2eb184bc8d118f7d4bb5a9e9f9f9b8771cabbab99ac37" => :mavericks
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
