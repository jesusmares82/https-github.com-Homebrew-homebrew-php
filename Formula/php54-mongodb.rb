require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.1.tgz"
  sha256 "65fac1b91b175b2c8dc92bd5939058a1c50d241ef66b7a155a3c96600366f14c"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "47062303deba1b0214340913cd85d6c0c228feae424a555827ce6d561b5edf1a" => :sierra
    sha256 "54530d2d05c4d1cf3b72d0895954a3db4ec30cb2b7cbcaecb064ecd27275c4f8" => :el_capitan
    sha256 "1b4a59370a80db85648bfc4e27633aa479ecf84a0894502677199678a64bed68" => :yosemite
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
