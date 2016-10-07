require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54V8js < AbstractPhp54Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-0.6.4.tgz"
  sha256 "88af2c98482374a36b24e317df4684b9eecc92d4883022fc8036a16f2641ca43"

  bottle do
    cellar :any
    sha256 "a704d12ce910f61d42b7ba893ce63b4bb796e928f116a8f3a3302e4ed86fd59d" => :el_capitan
    sha256 "bdc283c1e6988766470847e9cc54d361b1119ba177047769bd81aa1dc049775a" => :yosemite
    sha256 "200fd3a4b7ad96c71049e7b9d1ca1462df9b2bfa40efd22ffb35e1faf2f828ef" => :mavericks
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
