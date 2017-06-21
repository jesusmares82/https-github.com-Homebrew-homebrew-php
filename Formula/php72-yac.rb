require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yac < AbstractPhp72Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-2.0.1.tar.gz"
  sha256 "c9357c9779a87370b53f719cfcf86b80258b119376c718fea336988b1d7354a0"
  head "https://github.com/laruence/yac.git"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/yac.so]
    write_config_file if build.with? "config-file"
  end
end
