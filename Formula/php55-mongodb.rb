require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.5.tgz"
  sha256 "b3b9acec35663b0665d01f786e4d9b90a32c0e361d8b296527f1d7b2e4028bee"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "bdb57544b919a190cf43fc931e343a390f9c78c0e8b86ce6aa4d45739c828ae9" => :el_capitan
    sha256 "7e858151de73221403073f65efc110e3d91eb4e4bd45a064891cbae8ff1bf7ed" => :yosemite
    sha256 "b828660e67f361bc7a2a5579701afefe2ec7229d81dea745a03952adc779d271" => :mavericks
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
