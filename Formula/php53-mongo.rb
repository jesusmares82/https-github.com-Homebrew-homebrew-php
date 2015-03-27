require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  homepage "http://pecl.php.net/package/mongo"
  url "http://pecl.php.net/get/mongo-1.6.6.tgz"
  sha256 "8552b100231baf16e49c8d66a6ac064c36edc3172f6ab5a0ea924acc289eb0d8"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "9cad72211fff1d7d12437bef08244e05f00f09c671b7acb89b0b00cdd56f210e" => :yosemite
    sha256 "5d16521d5aa84ed169101410cd42bbfe63c55fd41b101db2b20de0569807b9c1" => :mountain_lion
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
