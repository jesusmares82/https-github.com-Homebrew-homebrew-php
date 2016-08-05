require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    revision 1
    sha256 "6e35d0a673cdb550eeb3ad2d203d50c1e238a3af118213a1c4599969753bc0de" => :el_capitan
    sha256 "49a33037f252d292bfe13fd8d21151ba1719a94aca2b436380e30147e00e8451" => :yosemite
    sha256 "4a8830358d9fcc08e8cd13818b22773dfbafe42fb67bdc93a63131f3072aae7c" => :mavericks
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.2.0alpha1.tgz"
    sha256 "03ac8a762949699aef0467ccdfbb8dfe70b57b0b57b740fe5041a4aff28685d7"
    version "1.2.0alpha1"
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
