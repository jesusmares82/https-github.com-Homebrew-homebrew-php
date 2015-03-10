require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongo < AbstractPhp56Extension
  init
  homepage "http://pecl.php.net/package/mongo"
  url "http://pecl.php.net/get/mongo-1.6.4.tgz"
  sha256 "b6ab5f4ade26ea328081c70bba43f048da3d669e536eebb9eb380f9db90dda6d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "9308036b4e795d3499148c26985ad14b93d0209ebb0c8477aa65b3ea4cf2d273" => :yosemite
    sha256 "465da206c5458934f1a64bc455463077ec2d00ddfb5a2c55ee4a2083e220030a" => :mavericks
    sha256 "b9e6da57c769af2827edf00f1a3870b9ddda0b19ca811622fb98ea94d8543067" => :mountain_lion
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
