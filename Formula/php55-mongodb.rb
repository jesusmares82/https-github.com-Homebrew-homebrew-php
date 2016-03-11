require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.4.tgz"
  sha256 "c6aee3b480d2e53b95ce9f4838c08d3f19722fccdb68c57ca11869cad4c3ff8a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "c1cf780e7edd4ee2be68ad94503c4bc63951996160e07f20c99659e437c7e111" => :el_capitan
    sha256 "2db382b8d18c3486d96589db77c82ea1c7abff3b3ecbe3566db6f2fa77fd8953" => :yosemite
    sha256 "4eacffe3022de27f8cbf31650b1071ab5d55cedd70258321af78fc385a3a37b7" => :mavericks
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
