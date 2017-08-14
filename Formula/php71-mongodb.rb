require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.9.tgz"
  sha256 "dac7f755001e454f41bd1ebf54a47754c524062d41244a75ea7ee3a9825a9d2b"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    rebuild 1
    sha256 "1c5a23019549a4f247e05175a207bd3483fc811b15ef50b3c272d128f3747653" => :sierra
    sha256 "c6dd292ae9b5c0137575e5bf588e89217354d0eda8c232241fbbe27dad97649e" => :el_capitan
    sha256 "af05ee70dbb9dca9e0c093791162b7f7b60f46d2b2c26c289746a42f95f37e75" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.3.0beta1.tgz"
    sha256 "bd93a9cd6b5c10158bfced6b11366bf56e8f822bf39dbcf0b15603f2328479c5"
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
