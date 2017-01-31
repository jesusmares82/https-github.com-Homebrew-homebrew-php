require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.5.tgz"
  sha256 "1d43c5038cd8cb7e6db57620c40f2cc6385bd538db002c60f61f44376d829848"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "5805d2cc457f7b9df5c49ba575e368c4d2944916a6efd76b369401c388d966b1" => :sierra
    sha256 "b09d6478718e9e0799484462f4728e95a56eda1eca35dacdbc9b1c11710ddc45" => :el_capitan
    sha256 "c471aff18ff34c5e1ec9774a835394009b1cf954404b9600ac270e3ae9c698bf" => :yosemite
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
