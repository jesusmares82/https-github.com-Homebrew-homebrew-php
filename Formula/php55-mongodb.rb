require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.0.tgz"
  sha256 "7ecec2ee3687a2d0985e389407e3c2fe9817bd3478c266b46e3e2a4656df4965"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "dcfcee9cd122710cc41adf4996bb493b16ecb4399eb585d16807d05ff5431962" => :sierra
    sha256 "c9ed09ca7f021743cf8b22f545129c4d4a8d8f774524937a3f58167c69d84a04" => :el_capitan
    sha256 "9d4d4628378eb79910699cf83cc966dcef09396859ab7c119d0096e5b8a93a24" => :yosemite
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
