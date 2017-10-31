require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.2.tgz"
  sha256 "3a24f60c1bfd68736977e53f40cd5b50eccf42472277ce8101ca7eea0fe82788"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "36e28fa85bcbd696ef9d29d6e22601b282f2eead076ca0d1eee52bb8c1b9b58e" => :high_sierra
    sha256 "312d0bfbd1f6b6fbf74ef4958ba67231e338b8bd56562451e042c3047d9f314c" => :sierra
    sha256 "1b9555d4a66345fd47a06e32e08f4a9e11c164b291562e19a6323050fc6417f8" => :el_capitan
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
