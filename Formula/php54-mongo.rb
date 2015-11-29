require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongo < AbstractPhp54Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.12.tgz"
  sha256 "3fec10526ed02ce0e54c4623839e35bfab17d16cb9e8a48c7fee126be351c990"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "2c06b9eda84c0c1afc84cd9a817bf43c826a58ae02328a1b846d62f8b0fff3b6" => :el_capitan
    sha256 "e6b22c35e57eb4eb3e17db33065432773140d3f940598f4bfc2a1a1b452b21fc" => :yosemite
    sha256 "0dbf63939f1f45ab73f5cf1eae4813d8fb31da066f32d9cbea36c495e5245028" => :mavericks
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
