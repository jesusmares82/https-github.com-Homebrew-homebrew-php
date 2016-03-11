require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.4.tgz"
  sha256 "c6aee3b480d2e53b95ce9f4838c08d3f19722fccdb68c57ca11869cad4c3ff8a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e28b7519b21def9dc1b3ef3307bf166a43e126fa102a89e8f6c1d58efc3e9128" => :el_capitan
    sha256 "eefa5280952d873dc7ff2a55157623d7fbf1b1f72ef07ccc803f6419334c2c78" => :yosemite
    sha256 "ba00ab30f56877b548fc3f429f289973ba8004b3a806c9b6f473e16195795d74" => :mavericks
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
