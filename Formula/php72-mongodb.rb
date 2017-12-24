require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.4.tgz"
  sha256 "c78190115c0d51a440d66c75b6c12192f6d97873d141b34c5c2406a816fe1bb2"
  head "https://github.com/mongodb/mongo-php-driver.git"

  devel do
    url "https://pecl.php.net/get/mongodb-1.4.0beta1.tgz"
    sha256 "427185ef5a668ccb79dcdbbd853b74664cee8fe0fbb9ce241ebc5919e36c3ac7"
  end

  bottle do
    sha256 "a97803dce4e623cb8bfef4931dcbcbf5e0219a7509d5870f56c593f58fbe3ac9" => :high_sierra
    sha256 "fbe696580169b3413327ed782f2cc59d1091e6150f0631aefb8a56d02afd2e94" => :sierra
    sha256 "1b33a2a1aad581cb8e09291ff2d978c1819e21d60541d6041eb60faefd88c091" => :el_capitan
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
