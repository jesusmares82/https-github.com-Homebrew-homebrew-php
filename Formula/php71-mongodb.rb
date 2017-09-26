require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.0.tgz"
  sha256 "7ecec2ee3687a2d0985e389407e3c2fe9817bd3478c266b46e3e2a4656df4965"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "d7af310069ac5f38a29668711075715bcd4fb40a17d38beb4242a6315f77c4b7" => :high_sierra
    sha256 "0c45442395f5d242f8e23a2888ce87610179afa93cb903f949015c3dcc359b03" => :sierra
    sha256 "72285b85ad0d4ab4915e21fd92ad8062d75cae2e2d9bab2c31d4710a899fb875" => :el_capitan
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
