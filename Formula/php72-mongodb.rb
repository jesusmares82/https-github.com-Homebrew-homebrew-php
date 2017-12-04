require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.4.tgz"
  sha256 "c78190115c0d51a440d66c75b6c12192f6d97873d141b34c5c2406a816fe1bb2"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "b44391648b72f0ceb2d86bbc0039af7d6c88071057c8ffdb67f911083d207dad" => :high_sierra
    sha256 "62d8b922b05e34d138fde89f405c1d4d117901f5243efaf47a02ad3759105bd9" => :sierra
    sha256 "b49a5dc1e325dfbf5f86eb41645842f252d00a90deefa56cd3e813ac96ae127a" => :el_capitan
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
