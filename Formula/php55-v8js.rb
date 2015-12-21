require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55V8js < AbstractPhp55Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "98bc8ae700eee2aa2680216aae2abcf5cd687764129b1513c94df88b1783a8d3" => :el_capitan
    sha256 "5348efcbe21afcefeade1480dce8e3de6314b5137c75ba71f644bd40acedd417" => :yosemite
    sha256 "7530065142a7f9ec98b25b60ae90313e10903615557b90ec536bb971527ead76" => :mavericks
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
