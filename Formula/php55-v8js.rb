require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55V8js < AbstractPhp55Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.3.0.tgz"
  sha256 "34578cdfe00d41623771c68f61cdc8dd06a66d044b5c22f9ed0a1999a35da39c"
  bottle do
    cellar :any
    sha256 "9aec1b0e86ef6103d52b3d0b0861eb40e82d7e5552653cff4d214b9a72503cec" => :el_capitan
    sha256 "e7f23eb8540a67ef23c1769f132742152f98b13330e676ea37ec90db64c5e8ad" => :yosemite
    sha256 "2cf1f0b4d2a9cec2d971e41b70bde57bf6b561dcc20773361f211bd91173f1eb" => :mavericks
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
