require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.0.tgz"
  sha256 "72630b038c7b57631a1d3931bcc1cb237fe79a25498b56ad65cc536d1bb0aed4"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "88b3e849ad6b4dab806b494920b65794bf925d059afe8b9f0dd6be0b37fbd13d" => :sierra
    sha256 "07ec86e81ab1f6c8dffe91322b9efb6469edf3fa06aa404d5177922ae8d60e6a" => :el_capitan
    sha256 "e6fa3199bfd2ee47840be3631a4a9388bd40ca79aea8806edc4cf739bb2ce400" => :yosemite
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
