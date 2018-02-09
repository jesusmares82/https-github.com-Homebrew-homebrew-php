require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-2.1.0.tgz"
  sha256 "2f1b990f91b8ee278a7f29e0f9dadfa694516d489493f1f05bcfb208a16fc33c"

  bottle do
    cellar :any
    sha256 "88be7b9986dcda9cf289a56ab5e92b0fb69da9ec691a1db50899c20d8e10cdad" => :sierra
    sha256 "ee0146eedef6c2ceebf7ea0193dfed7bf5ec59d6ec5eda242346602fc8cd6c13" => :el_capitan
    sha256 "16b0201e254b77e2aa753bab0223e820bc112a2fa8e20191138dc461f7f38de0" => :yosemite
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
