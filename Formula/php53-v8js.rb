require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53V8js < AbstractPhp53Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "6fec66bacd3f8ca5a32b2c3938fe2bfcd2700ea27ae968dc649a4ab112831f29" => :el_capitan
    sha256 "aa92850097bfa1bf06c6fa93360c4c9b86358988ecb3f20c92a77504c67b841e" => :yosemite
    sha256 "4bbe4dc5248fee0536b9a60ed630b301887c6c2e118d336d0bf580dd8e22f51a" => :mavericks
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    ENV.universal_binary if build.universal?
    ENV["CXXFLAGS"] = "-Wno-reserved-user-defined-literal"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
