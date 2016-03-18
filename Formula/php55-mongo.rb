require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.13.tgz"
  sha256 "ed081b87e40b16b2878579ede456f34cda6575c31baded5e4af29ea14993d783"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "eebab2ac24d10d3df45acae5dfe473f0e3a5131f9b834a341ad19aa2a01319dd" => :el_capitan
    sha256 "8054ca4431c21ac3e857038f21f0845c38a03ebe83e85e4d7b89bb76579c0184" => :yosemite
    sha256 "e5f6334a9f6e2c1fda72d110b81e3073256445066823dda2fcf4c34a9d300bbb" => :mavericks
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
