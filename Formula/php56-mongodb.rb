require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.0.0.tgz"
  sha256 "a1f0ac6835190ce119b3b0646b6918713132e6942003f38dd7a6579e8f255aff"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e3b71ef138862450d08a33b83a9e62170e904fc204d4345795e985aad01f57e7" => :el_capitan
    sha256 "90039dd2a38f42e87ebb99c5ccf3aaf6aa169b23059de9cef493cb1d8ea97216" => :yosemite
    sha256 "f5f1b464c092c9611bf4740e3f2ebe304061387e672352409633e47514dd78b6" => :mavericks
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
