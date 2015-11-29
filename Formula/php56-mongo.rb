require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongo < AbstractPhp56Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.12.tgz"
  sha256 "3fec10526ed02ce0e54c4623839e35bfab17d16cb9e8a48c7fee126be351c990"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "262d677dfaaa6b0072b435dc684d3e7fb31507c1f56ba179c5d688bb141e0e29" => :el_capitan
    sha256 "53255cd3a7607c6f7d8bfc9a477e4b64baa0f1ecb383ea91f01ea5408557212b" => :yosemite
    sha256 "1f37563c2d4890dbdd4da99349d699f4e7f2bdd41d093f525725104af957247c" => :mavericks
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
