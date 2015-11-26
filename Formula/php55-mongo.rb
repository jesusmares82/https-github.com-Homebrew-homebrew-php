require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.12.tgz"
  sha256 "3fec10526ed02ce0e54c4623839e35bfab17d16cb9e8a48c7fee126be351c990"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "798d4bc81abcd7dd542af61f33c7c2c95e0155c41dce0b934ccca8244c077ed7" => :el_capitan
    sha256 "3576bc7d85d9dcf819cad6853dd1a85abf99884484f960fd09a833649220a949" => :yosemite
    sha256 "2ba12276066a32e66db84e67a0bd7f10165f7cc8215e703bded4a81f9fbb056a" => :mavericks
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
end
