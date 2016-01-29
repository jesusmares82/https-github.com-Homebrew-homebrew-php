require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Hprose < AbstractPhp55Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.4.tgz"
  sha256 "e3d96cc51cf442629e7298af153c55e4bd85d832de43f22eb5f0fabe49abacca"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ee8f27662124e8885dc0a9f5597fb93ee946b20a4a936424132847adc8892308" => :el_capitan
    sha256 "ba9dfa355a8bc2a7969f6614e800903bcaa4465313141a02b68d9de7e031fb2f" => :yosemite
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
