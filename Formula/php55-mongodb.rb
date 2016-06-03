require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.7.tgz"
  sha256 "65bfb564d9a53a7642a02f07085bd9055b43522250649886ed65a37771cf9b49"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "e503c322cedca8f32c095a1b773a7cac68688af1749dd647b269b3d0688fc765" => :el_capitan
    sha256 "01be526585a2f0e59da87b29ae56c1c73135e1c8b183ffcd7c99e5e2a0e206e1" => :yosemite
    sha256 "4b0c4ce0ac1f0ccded6d8ccf47971c5c3b4c4b338f7a8687197efc5f8861820a" => :mavericks
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
