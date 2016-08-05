require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.8.tgz"
  sha256 "b93ae7dc9bd270823965f8903c9acf47fe3a0ba7a630d08e8173ff091d593ae0"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e6eedeb17fa61526413c6b9a7c813f1658eec3139faea6af11d1f97f9aa498bf" => :el_capitan
    sha256 "136804ff251a23c272dc3424a29f9564fd58dede9280653064d3586a688e8282" => :yosemite
    sha256 "1f92112c2d4a0a6e0a24d788cf49d2956d60bb75ad79e2bf20cd7f2d9188e59d" => :mavericks
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.2.0alpha1.tgz"
    sha256 "03ac8a762949699aef0467ccdfbb8dfe70b57b0b57b740fe5041a4aff28685d7"
    version "1.2.0alpha1"
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
