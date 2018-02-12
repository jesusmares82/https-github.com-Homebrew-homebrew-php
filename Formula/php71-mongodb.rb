require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "f252611a51c9974319767b68c45d158f427fd37c16fe84e9c76bfa27c492e38d" => :high_sierra
    sha256 "ef89679a6bae38a200e258465f5c161a57831a1624f7d0dddf6aa2edeb3cda98" => :sierra
    sha256 "30f4a71c580ca48e8cf3a8af0eb9f9f1953a425786a01db09608fea1b64875f5" => :el_capitan
  end

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=darwin"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
