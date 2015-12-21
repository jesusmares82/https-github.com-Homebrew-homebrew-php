require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54V8js < AbstractPhp54Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "f989a82cc7ad7a190ac76595697a488fee9c6293a8067fcad7eb31c58f8b1772" => :el_capitan
    sha256 "c515d5bbb03c39b41f15421d404340b821a8d6f0bcf311a2628c6dd7c5ce8166" => :yosemite
    sha256 "f5f2335628ffa89adc0d6f54e5038b283207fc3ab2fe34db34edd488e828f965" => :mavericks
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
