require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.0.1.tgz"
  sha256 "d31b98f2f58fce4d8183197fd8415ad71d8569852b85540316567ab1f647b9a0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "72addaad53d071d27b06a71e21364b9fd105fd2535736bc4e689c5367587531c" => :el_capitan
    sha256 "4762a9e9d95dc3edfa2ba13b1976524858507eb301f8181aa3a543d4eb78d0ba" => :yosemite
    sha256 "94dd23a13cf27679304049ed4444a3a4f7b2fe9f81c8074f394f627477efabaa" => :mavericks
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
