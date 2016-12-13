require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.2.tgz"
  sha256 "cbe02827653c3c03949ce96885e6be27b014322f642c89788510cdf3b5dbe3d4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "162e1aec251bd2bdb561e2d5aee41d554724584eba87bc57d43ee61c56c1f356" => :sierra
    sha256 "74b6f8a667d3618cffff32cbd93a2bb4769c19a52169bc86da5d7509c3acfdae" => :el_capitan
    sha256 "8803efc8d338347d1cb7a143d0bfd95fad20aa4bc81d54644877faa2465b8422" => :yosemite
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
