require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.2.tgz"
  sha256 "3a24f60c1bfd68736977e53f40cd5b50eccf42472277ce8101ca7eea0fe82788"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "7a899edf1e5a59ccd30980ffd507aad402f2f9c25109b2f51f1d952081516775" => :high_sierra
    sha256 "2703180e362f2702825f6e7b72c885867588b1acd9474101f155b7e3c10d6407" => :sierra
    sha256 "2b87b0171da93adb684b307ee81b3bee946ae6cd2a91dabf7283beb51716f086" => :el_capitan
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
