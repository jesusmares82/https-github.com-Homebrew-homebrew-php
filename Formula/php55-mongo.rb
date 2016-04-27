require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.14.tgz"
  sha256 "586a0f55d29198010da5f4c932a183491f114db6e1b0ba8e40e7246b1a4a96d0"
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
