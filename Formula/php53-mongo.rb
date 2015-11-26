require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.12.tgz"
  sha256 "3fec10526ed02ce0e54c4623839e35bfab17d16cb9e8a48c7fee126be351c990"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9b69878604cef04a3197901143e4b9236b3013088543533a7a760f897e556e1c" => :el_capitan
    sha256 "abf28abcd0e4b0c8cbc3664ea5a19119436dab1637c0a7759d52946e7c6ff0dc" => :yosemite
    sha256 "c5a48400df12ab8cd2f06dcd5fc0a0be951d8fd9a8c4fa04e49fa0d866d7224c" => :mavericks
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
