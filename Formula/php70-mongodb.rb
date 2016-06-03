require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.7.tgz"
  sha256 "65bfb564d9a53a7642a02f07085bd9055b43522250649886ed65a37771cf9b49"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "0558a44f957c3d1dab621a2d429ae8a54ccffcf0f5a52f0f130fc9c7c536e10e" => :el_capitan
    sha256 "1ae55208a87ba858acd85f7b37dbb94c351dac5008a3dd134c02ff23a486f7a5" => :yosemite
    sha256 "b7f39f418741c175707499fb90369d69c2e418d97cda4dab1b918a7250717cde" => :mavericks
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
