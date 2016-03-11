require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.4.tgz"
  sha256 "c6aee3b480d2e53b95ce9f4838c08d3f19722fccdb68c57ca11869cad4c3ff8a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e7d7b1a25760aa1dcc6b81beea82646e09b8bd76874b8b2f7cb7500f0427a04e" => :el_capitan
    sha256 "6b7025a2cc5833e36d6abb79d0da400acd49a4c9a7a88b68a3626f2827ff36b5" => :yosemite
    sha256 "f5f7a4e94e9935c3c6c67124a2cf9fd396f552e1cf6bfff088b3ddca2cfa45df" => :mavericks
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
