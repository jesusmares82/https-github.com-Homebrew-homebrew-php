require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.3.tgz"
  sha256 "c9c4ecdfbfcba58e8b02d2f6f3fcbce661e3715fb15addbf6155615c152af8d8"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "32653b4b6a4c4e3027f4bb0f4f988fcf150dce25a3bf8cb80be69c9b1c285f12" => :el_capitan
    sha256 "4434a97fdf762f19736ce290213d672c5b1f7c810a96b0e338e39f12cdc2044c" => :yosemite
    sha256 "b2d5635b6c552b52eaaff3f84cbe739a9d413d6aad0b5a7f62c2bc45941e3f76" => :mavericks
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
