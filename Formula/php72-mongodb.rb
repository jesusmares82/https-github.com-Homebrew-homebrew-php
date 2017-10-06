require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.0.tgz"
  sha256 "7ecec2ee3687a2d0985e389407e3c2fe9817bd3478c266b46e3e2a4656df4965"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "3ffb62f00c4fd7727498e1015a52a14c32fc6015425c2124c9267dd93490c29e" => :high_sierra
    sha256 "508e48b1910040f1fb6878035459b627bd58a567f1822ce991bd188e19f0773e" => :sierra
    sha256 "e6664710a20a055b8aa784ad2b57a4c28477d679511ef298e960c534f99e8627" => :el_capitan
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
