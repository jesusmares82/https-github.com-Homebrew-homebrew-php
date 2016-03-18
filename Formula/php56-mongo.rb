require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongo < AbstractPhp56Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.13.tgz"
  sha256 "ed081b87e40b16b2878579ede456f34cda6575c31baded5e4af29ea14993d783"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c62565cf7c47b1b7d99a148c9009cbaaed84e4db829f03d7618c3e6683bc105c" => :el_capitan
    sha256 "081c84c5cca22f1bf678c6fbbbef1b88324bb32fb561d807f35c493719261896" => :yosemite
    sha256 "1e0247d32d2e20a0c06577664bf4009b59f75dadb62515d772da7a09919b2f0a" => :mavericks
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
