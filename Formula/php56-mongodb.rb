require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "cd70705244d1a780697decc4ad7b330ef7497a0c54e6468d830446a557741c00" => :el_capitan
    sha256 "d9f2ef6be95d8ba67fa7fee8934ffae23516fdb378c3dc806b2cd180b9cacb3e" => :yosemite
    sha256 "28110a0f0c4f759656992df146d389461c39b997e076e3ebca30ef9803c8d4f2" => :mavericks
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
