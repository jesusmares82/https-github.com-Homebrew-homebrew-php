require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.5.tgz"
  sha256 "1d43c5038cd8cb7e6db57620c40f2cc6385bd538db002c60f61f44376d829848"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "73fa8e9d04dae079bef7ee46ba35e9a1b54242fb73e0f473c5c5f7d1e25f31e0" => :sierra
    sha256 "724f193a13d0e8bc95ae6e4f189322c815189fecf421786c73256454b4e10f86" => :el_capitan
    sha256 "4c8960726af576039b9433cb335bfd0e851c19c116cfa83e3313c9c1f48b9b58" => :yosemite
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
