require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongo < AbstractPhp54Extension
  init
  homepage "http://pecl.php.net/package/mongo"
  url "http://pecl.php.net/get/mongo-1.6.4.tgz"
  sha256 "b6ab5f4ade26ea328081c70bba43f048da3d669e536eebb9eb380f9db90dda6d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "178f91309a89315f6a795d7a20a16087205f5b7afd38774970970b2b78e93df5" => :yosemite
    sha256 "6733141ea2d34df924fa8036fcab315a75b765f079a6953574fedded0150e3cf" => :mavericks
    sha256 "aed4974a072a30ef8f41a8a9421171dc8818da612a7a9d826cf1d99dd3f7a1a9" => :mountain_lion
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
