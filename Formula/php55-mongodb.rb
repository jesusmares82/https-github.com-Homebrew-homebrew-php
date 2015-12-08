require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.0.1.tgz"
  sha256 "d31b98f2f58fce4d8183197fd8415ad71d8569852b85540316567ab1f647b9a0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "c94d42bc6a28f8bea8f5dcfd82e90f0fe80b3185b02c70d9a6b2b2a0dacb84db" => :el_capitan
    sha256 "7ff1cb5a1533b5a143e9e5077823971e5e8e51ddc10d1acd6ae6f38c78c249bd" => :yosemite
    sha256 "aaa27863814a9f95f0727682e02b64ed8b0f2e7314d90299806c896e561f1dc0" => :mavericks
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
