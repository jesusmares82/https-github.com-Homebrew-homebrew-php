require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.13.tgz"
  sha256 "ed081b87e40b16b2878579ede456f34cda6575c31baded5e4af29ea14993d783"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf68047769497f581853e1946586518ea2a6819a83876925fc286802d444519d" => :el_capitan
    sha256 "13bbe6c632ece1eac63d5a0697e7b9281489929c53573a2075de15a57fb10951" => :yosemite
    sha256 "0011fcf943e83dd83452877452f98b125bf72d61d971eaa2bca91d5677602113" => :mavericks
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
