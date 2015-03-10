require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  homepage "http://pecl.php.net/package/mongo"
  url "http://pecl.php.net/get/mongo-1.6.4.tgz"
  sha256 "b6ab5f4ade26ea328081c70bba43f048da3d669e536eebb9eb380f9db90dda6d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "cdd15fb7a214469ec861529b2fa4792b2a9f313ef66ac44be9873ee1100b807e" => :yosemite
    sha256 "ec7a0be301ce06dc97c959c62fde417ec417d4ef460d5381a7d41cf46948931f" => :mavericks
    sha256 "e3ce71a166a00257251ee1ac1ef3610ae1773fa4d1683672fd40eb01c690646f" => :mountain_lion
  end

  def install
    Dir.chdir "mongo-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("mongo")
  end
end
