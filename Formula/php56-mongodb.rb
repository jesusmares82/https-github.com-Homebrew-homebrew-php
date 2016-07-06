require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "c8ba85ff1dd0f705aa192a4fb6cde35f56c6977a8bbaebefe6f0c4b04eb80639" => :el_capitan
    sha256 "e1604d1e593c15822cc0c0906ccab4b9721ddb13baee7dbe8edfe55476219835" => :yosemite
    sha256 "cc52f7034e96a67dd6da2ca5ca4b49417293f545899eab64cde3517b8cac5658" => :mavericks
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
