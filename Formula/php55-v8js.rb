require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55V8js < AbstractPhp55Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  revision 2

  bottle do
    cellar :any
    sha256 "44bcb17a9ae81fae5f9484b8b95011f305191556b7dd2239aa2bf21443b19155" => :el_capitan
    sha256 "a26ddf30148d36293c4e82a8d45daa94b75795523481b443785280f8cf39d3d7" => :yosemite
    sha256 "454b49355e63703d40b9c02d7217cb87fd348e3515a722681fe0eded18d6d015" => :mavericks
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
