require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.3.tgz"
  sha256 "6c8f6b28ae69223df8f6c43ceef5776e60306910332c8f0c68d4096680a96a62"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "5c1cc17be6ec10d8030918bd6fb212e9e4710e9fee3f1dd5925a705fcbc58e1f" => :high_sierra
    sha256 "7be033c72e0c353e709294deaae2933179abf2829b2c97e9f2f300853b4ef149" => :sierra
    sha256 "74c0f6142c903f7506754fa90a2e3a99e3a051da478e2765bb602d387b758f6e" => :el_capitan
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
