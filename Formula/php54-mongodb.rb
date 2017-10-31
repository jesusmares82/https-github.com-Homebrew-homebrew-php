require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.11.tgz"
  sha256 "bac347be2277dd64b1b6f414234a6057eccf2d208409ce60973107a41267df49"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    rebuild 1
    sha256 "52d130608226cfb8da452be1eb91979235908ffa9c6adc35e625134efc3e3df6" => :sierra
    sha256 "b6fc369894fb570dde1653e593a49e02684be741c750a3a3e58ff38eade8472a" => :el_capitan
    sha256 "8abdc909d2d3b787850de4ee27b3b2d6c835e8af6eb92bd30cfb56e760a26100" => :yosemite
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
