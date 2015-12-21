require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56V8js < AbstractPhp56Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "85b17932930303d6a1890552b586f6c785d2779eb03392fbd882db632c666924" => :el_capitan
    sha256 "2be68e98f7381de6b79c8da267da5fad2c4e505aee93709fb4db41b06ff2bcfa" => :yosemite
    sha256 "c8c3a4e9b81db1d94ac6025878bd1dd5cfd6cc8426cb66df97f7902b74816b4f" => :mavericks
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
