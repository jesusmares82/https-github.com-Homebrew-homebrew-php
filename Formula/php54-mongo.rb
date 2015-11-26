require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongo < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.12.tgz"
  sha256 "3fec10526ed02ce0e54c4623839e35bfab17d16cb9e8a48c7fee126be351c990"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8ba17b21393fe8752efc642778092bc09ab182a8910ae4f02ebee5d95f0d0cd3" => :el_capitan
    sha256 "2325bced1bb921f4269bdf0c706d86dd8128cbcaf60e1325b012f842d0beacbe" => :yosemite
    sha256 "4fb9da8506c840f31a69c3f43f5deaafdf0ec74a7ab2589242392ab3589dceb0" => :mavericks
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
