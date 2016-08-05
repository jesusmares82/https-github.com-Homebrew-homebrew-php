require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    revision 1
    sha256 "76317b88b6a62803cd438815d42f8e4ac656816be7f46d278ee69dce77ca47c4" => :el_capitan
    sha256 "65b88cc44d91b45bfbae6293279fc63d1af55d69a0c3b4148ad3b57af06e299d" => :yosemite
    sha256 "16e6d5d3bcab7495e2f0de9f736348b8bc3101ae222f2a37bd40ff6855ec5945" => :mavericks
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
