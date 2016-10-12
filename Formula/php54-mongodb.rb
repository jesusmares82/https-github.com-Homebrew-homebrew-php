require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    rebuild 2
    sha256 "da437bcb61142b7c58889507d308383da5c14e46b84504e226501127c8fa82df" => :sierra
    sha256 "377da259767f03698d174398609498d3cb30c121e4034ea724772e5a3cc8e187" => :el_capitan
    sha256 "bd61865e370e2828e411d4d3c4da39231133fcd15f4b874fd203e1e2c9f98c7e" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.2.0alpha3.tgz"
    sha256 "295ff6792e734c5d0352efb0f2bb0c1dad25114d5c48bd98004d7650d742de3f"
    version "1.2.0alpha3"
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
