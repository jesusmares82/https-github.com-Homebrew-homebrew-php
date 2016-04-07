require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongodb < AbstractPhp54Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.6.tgz"
  sha256 "cd4bb7402911431098ef6c12562dca53a89808ed1ba9798131002be1c61c6b59"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "bd8a0f28e8c7fb6f3cc3c955b8f4f958213a46a723fb9e5a0a938d7c68f66300" => :el_capitan
    sha256 "5eec4044db6168264de0e211138dab2d6ad337f7bb40c4cdc67ce54507405855" => :yosemite
    sha256 "b8bb418e10967e5142e6d8951fdfd88eefd1165e265c4a4ddc7c19e67569325b" => :mavericks
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
