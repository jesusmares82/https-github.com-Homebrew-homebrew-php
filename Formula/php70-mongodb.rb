require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.2.tgz"
  sha256 "4cb80002dfb6be0805457ef0c9f4e91fd03c2e54baedac958ad1e498c741484d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "688418c6b8a0623f4f5c1883055f47c0e1018d17db2b5309dc0903172cefaecb" => :el_capitan
    sha256 "b85cc91ed796e814cee06197aa1785e237b70e2ad058e6f3e013c45d7566da4a" => :yosemite
    sha256 "fb07b54f0a07d6020c446753cc626531bb0365dbdc6087a4c274ffc4be7a9197" => :mavericks
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
