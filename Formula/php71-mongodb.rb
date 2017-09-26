require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.0.tgz"
  sha256 "7ecec2ee3687a2d0985e389407e3c2fe9817bd3478c266b46e3e2a4656df4965"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "1c5a23019549a4f247e05175a207bd3483fc811b15ef50b3c272d128f3747653" => :sierra
    sha256 "c6dd292ae9b5c0137575e5bf588e89217354d0eda8c232241fbbe27dad97649e" => :el_capitan
    sha256 "af05ee70dbb9dca9e0c093791162b7f7b60f46d2b2c26c289746a42f95f37e75" => :yosemite
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
