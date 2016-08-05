require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    revision 1
    sha256 "b728b6c0e2550d594ef9422714642bc33643ce8ccf2b566e241d389907b52394" => :el_capitan
    sha256 "dcb95478df1c0d9652e62032d7cb57747df92e78573d1401162d289e743a2660" => :yosemite
    sha256 "c2566b2bb4c6f5c05fe5cf41022ac486a4a310fe1dd383b0883029e8a14c04a1" => :mavericks
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
