require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Meminfo < AbstractPhp56Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v0.3.0",
    :revision => "a9e0eefe0b9c88abd7215f688ec0b04d0d20f386"
  head "https://github.com/BitOne/php-meminfo.git"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
