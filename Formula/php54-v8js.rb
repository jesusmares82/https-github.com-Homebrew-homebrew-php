require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54V8js < AbstractPhp54Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "bb0f5ac5e313294fc225f8dac5d7bc76d40610885af96f4007ff87f3b0bc735f" => :el_capitan
    sha256 "c67c5e620fdd9c3c6a7ebaa8d538864b13521929212791055af3a01f02dc8eab" => :yosemite
    sha256 "d1510667eca5c327f83ee26f4bc8d9e19f237deeda17ede10722251c76f32c68" => :mavericks
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
