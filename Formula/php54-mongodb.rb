require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.3.tgz"
  sha256 "c9c4ecdfbfcba58e8b02d2f6f3fcbce661e3715fb15addbf6155615c152af8d8"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "7a4424c70b72f12ba0ea920cccdfb948bae2ff0515667c0aa55ce51ca1fe23f0" => :el_capitan
    sha256 "dd89e3abeeedb54a43f755023337b7af108c645c519803351cae1e74248e8dc6" => :yosemite
    sha256 "d1f8a589e2a150f04278e73f36cb5b120b9a66995b7d1af2ccfec74838fece3b" => :mavericks
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
