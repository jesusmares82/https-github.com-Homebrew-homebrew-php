require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53V8js < AbstractPhp53Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "27e2538c6136bef7a5f283794695e582a1054c9021c769367941ed5d4a0fe020" => :el_capitan
    sha256 "3ec511352fac9d7125d8e1151c7f1520b89582953e985720151d0f76d211ecfa" => :yosemite
    sha256 "7c80e9795dc13fa4457db75378c2a0d16d94a948fd850e4d80c113c98fda5d39" => :mavericks
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
