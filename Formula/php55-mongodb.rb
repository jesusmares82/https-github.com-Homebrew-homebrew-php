require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.6.tgz"
  sha256 "cd4bb7402911431098ef6c12562dca53a89808ed1ba9798131002be1c61c6b59"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "1726ad74002e0357ba9b07698f4137041c83d03bdee6eadd7fe6bc2f1e2ec520" => :el_capitan
    sha256 "64a44a65de8f7ae5d5e5407e55ed75e8a479cf4ffe5f39cc12fc57ae9314cf23" => :yosemite
    sha256 "73e2bf4659a9a3b779c8a40714c95586521ba4766d9c24e636f0ca56aaae5e27" => :mavericks
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
