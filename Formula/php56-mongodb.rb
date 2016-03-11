require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.4.tgz"
  sha256 "c6aee3b480d2e53b95ce9f4838c08d3f19722fccdb68c57ca11869cad4c3ff8a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "9b0c91bc939a327ee7962ef2a4340ea1ac772d80a955b0814059d8168f016c80" => :el_capitan
    sha256 "a2c34bd18bcecd0e84a990914129b020492f183bacb22bd537a35b314c8c9759" => :yosemite
    sha256 "fc7c05c16a98dd3a50c05be2efafc8d3bcbf5d2e853f1ef0c94bdbd162a76b80" => :mavericks
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
