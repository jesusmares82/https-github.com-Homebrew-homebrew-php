require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Hprose < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    sha256 "43de63e85884ba8bb82287301d781cce4f47c086f08fd62d08a6b1c48495ddda" => :yosemite
    sha256 "bf1f86ec382091a55e926df033bf321fbab6dd27ab14826b44914693855a677c" => :mavericks
    sha256 "de8fbd20f2ff2f9269e9db215ea795d0f9217d4e6285e9cf47bb88b92a18c3f2" => :mountain_lion
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
