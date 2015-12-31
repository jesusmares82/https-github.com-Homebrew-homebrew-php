require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.1.tgz"
  sha256 "0899b00435edf143ddc0ededd8027013c86bf59214d63ae1f3c7be0eaae11ceb"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "cc6c1808acd7513ceec8805d73dcf7e11c1e608e6fad261a1fc311c70331f7a8" => :el_capitan
    sha256 "4273c59eaa30160894f16aae4f6d4055a9305645ed9d2dd4ee5b22e43d57e4af" => :yosemite
    sha256 "8b29256eac4b00a45500d8933aae87699c3f1c23b5dac280f72e6771331815b2" => :mavericks
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
