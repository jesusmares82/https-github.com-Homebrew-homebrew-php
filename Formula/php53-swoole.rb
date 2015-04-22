require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Swoole < AbstractPhp53Extension
  init
  homepage "http://pecl.php.net/package/swoole"
  url "http://pecl.php.net/get/swoole-1.7.15.tgz"
  sha256 "5328b1230e5ccdab519fdcbc315fef3d219ff813bff8daeb45a2f9f50316e409"
  head "https://github.com/swoole/swoole-src.git"

  def install
    Dir.chdir "swoole-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("swoole")
  end
end
