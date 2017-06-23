require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timecop < AbstractPhp54Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "acdfabdee1f3a5095f3d341b344ccff14751d2511920729c20796d49b03851f5" => :sierra
    sha256 "c9d7f82e76a61c7eadd6cb177e2348f88eb73c2fc7d2a8f36461c50ecf240583" => :el_capitan
    sha256 "10c229f522cdde9362d3e10c29d871c36a5b36d472aa266fdacbd3ce18c79429" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
