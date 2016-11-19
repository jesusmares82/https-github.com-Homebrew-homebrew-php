require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yac < AbstractPhp53Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-0.9.2.tar.gz"
  sha256 "d99023db0f73b0d3ba07b5ed1e9386182c5040202b1c2a4891e90df7b040afba"
  version_scheme 1
  head "https://github.com/laruence/yac/tree/php5"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/yac.so]
    write_config_file if build.with? "config-file"
  end
end
