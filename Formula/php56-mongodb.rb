require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.1.tgz"
  sha256 "0899b00435edf143ddc0ededd8027013c86bf59214d63ae1f3c7be0eaae11ceb"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "361cb03244747e3135890aa15f5b93e9cb5ef97861e4f1b1b31acfdd60e0be1f" => :el_capitan
    sha256 "b0ac1ec5b288f0338dffdbcba9c8ca1936ad51b402aeaf98ef82103f1ec1ca9f" => :yosemite
    sha256 "b5d109526fa5235080709b3fb8cf75d30840a6d8e6a40f7838404527e7c63fec" => :mavericks
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
