require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "a97803dce4e623cb8bfef4931dcbcbf5e0219a7509d5870f56c593f58fbe3ac9" => :high_sierra
    sha256 "fbe696580169b3413327ed782f2cc59d1091e6150f0631aefb8a56d02afd2e94" => :sierra
    sha256 "1b33a2a1aad581cb8e09291ff2d978c1819e21d60541d6041eb60faefd88c091" => :el_capitan
  end

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=darwin"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
