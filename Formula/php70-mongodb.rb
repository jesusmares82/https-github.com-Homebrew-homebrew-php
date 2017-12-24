require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.4.tgz"
  sha256 "c78190115c0d51a440d66c75b6c12192f6d97873d141b34c5c2406a816fe1bb2"
  head "https://github.com/mongodb/mongo-php-driver.git"

  devel do
    url "https://pecl.php.net/get/mongodb-1.4.0beta1.tgz"
    sha256 "427185ef5a668ccb79dcdbbd853b74664cee8fe0fbb9ce241ebc5919e36c3ac7"
  end

  bottle do
    sha256 "165bf4beb4b4bce9e8e3c3fe9df7f877e0bc2ecfa381d537ef9240b6c34aeb8e" => :high_sierra
    sha256 "bad3b304fa4b9735d41f9ef6ca1f9074c6e62e92076651b380e65892a9e8b76e" => :sierra
    sha256 "5a7ebe978e7edde595922c854823dbd8006ac4f0650ef5eb8919c8b17d711221" => :el_capitan
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
