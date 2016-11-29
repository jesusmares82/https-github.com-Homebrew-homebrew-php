require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.0.tgz"
  sha256 "72630b038c7b57631a1d3931bcc1cb237fe79a25498b56ad65cc536d1bb0aed4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "8aeb6e0b8a6da748f22a096a8f1dbc9b441810f6bc7a7d80e82fd5ab7d22bc91" => :sierra
    sha256 "ddccce31bc4c7e4ee0437f7e0d26f98db6f2d483c7f450d4b1771a4a0f4f96e4" => :el_capitan
    sha256 "d4e6959f022da9f39859cacab9a89d84903788a7bc64791b067a832aff322d65" => :yosemite
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
