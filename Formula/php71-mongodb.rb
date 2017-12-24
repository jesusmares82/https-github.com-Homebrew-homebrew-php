require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.4.tgz"
  sha256 "c78190115c0d51a440d66c75b6c12192f6d97873d141b34c5c2406a816fe1bb2"
  head "https://github.com/mongodb/mongo-php-driver.git"

  devel do
    url "https://pecl.php.net/get/mongodb-1.4.0beta1.tgz"
    sha256 "427185ef5a668ccb79dcdbbd853b74664cee8fe0fbb9ce241ebc5919e36c3ac7"
  end

  bottle do
    sha256 "f252611a51c9974319767b68c45d158f427fd37c16fe84e9c76bfa27c492e38d" => :high_sierra
    sha256 "ef89679a6bae38a200e258465f5c161a57831a1624f7d0dddf6aa2edeb3cda98" => :sierra
    sha256 "30f4a71c580ca48e8cf3a8af0eb9f9f1953a425786a01db09608fea1b64875f5" => :el_capitan
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
