require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71V8js < AbstractPhp71Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.3.3.tgz"
  sha256 "049d04cbdcb901f358f04bfe0f89337c625b3fb0bbca335af2e2d0c4490412f2"

  bottle do
    cellar :any
    sha256 "09c722ff0822acd8c45000249e1d9aaa381b23e9f00fe769337825d3cb931e7d" => :sierra
    sha256 "9ef25eff64edb1a4bcbd5d06e6db18fbf5edaefc7b2b7114fbf6b50e7b2fce53" => :el_capitan
    sha256 "1a6db9ed43b7ba01a66feb8db7aedb1bb123c19e9ae399b214bbbd9a98002264" => :yosemite
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
