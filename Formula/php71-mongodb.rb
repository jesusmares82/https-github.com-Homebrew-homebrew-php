require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.8.tgz"
  sha256 "38090c38f0d52dd0a4c41c4f7f7e4e4a86a6375b6c5009e754b19451212d0bdd"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "a97e892cb86b62a1a369aceb2c13cd2764c68d95fff354496eda97389f912604" => :sierra
    sha256 "90fab532353c59de6d197137284dc924033c2c1d2fef267b831eb6b38aa704cc" => :el_capitan
    sha256 "682c5b9abc48a0c15f415d23339bf2df1a6962ea0a479ccf4b1777ee3b0d8fce" => :yosemite
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
