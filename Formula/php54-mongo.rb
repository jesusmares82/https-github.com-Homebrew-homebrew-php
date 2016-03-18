require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongo < AbstractPhp54Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.13.tgz"
  sha256 "ed081b87e40b16b2878579ede456f34cda6575c31baded5e4af29ea14993d783"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9755a725c83a116d2bd118a85aa71372ecdcf9222daf1d2debce77078c796e4b" => :el_capitan
    sha256 "a87a36e867ddfe08d34288734017725ee2885be2ec37231ba2b113d90f919257" => :yosemite
    sha256 "461b0889819ca94e70c7507b9f5ee835f9a02654cd9c831fd9e840405dd348ce" => :mavericks
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
