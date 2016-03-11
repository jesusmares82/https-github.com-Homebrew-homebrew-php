require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.4.tgz"
  sha256 "c6aee3b480d2e53b95ce9f4838c08d3f19722fccdb68c57ca11869cad4c3ff8a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "7c1c0ec00ff6d41104ec9dcee070b9e4f93f2167641a96d7c267b1fb7ac9bf9b" => :el_capitan
    sha256 "a2dde35f119c5110244715c7a9f2a242dd24a218553b3a83bbea0c55cd130c9d" => :yosemite
    sha256 "365a0ed7796a887a57e01d216ec84144a78917c0ab6c21eb425832706db6e283" => :mavericks
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
