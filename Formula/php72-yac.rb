require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yac < AbstractPhp72Extension
  init
  desc "Fast shared memory user data cache for PHP"
  homepage "https://github.com/laruence/yac"
  url "https://github.com/laruence/yac/archive/yac-2.0.1.tar.gz"
  sha256 "c9357c9779a87370b53f719cfcf86b80258b119376c718fea336988b1d7354a0"
  head "https://github.com/laruence/yac.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0caed93e4a5e1e824d328be94dff6eea1531140123b32dd0213e905dbef31828" => :sierra
    sha256 "1e74ff64b4a0656bcec3ea396839c1dd2670323ce272635beef5f08e6be21097" => :el_capitan
    sha256 "5bd24abfd6ed69e52160f29aa5256cb2c684f526e5f2276fe084b6608a651bfe" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/yac.so]
    write_config_file if build.with? "config-file"
  end
end
