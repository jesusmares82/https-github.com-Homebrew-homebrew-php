require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Timecop < AbstractPhp72Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e30c17ea19633a5adaf614bc9beda974ce081c33fff30b7e0d1428306e389963" => :sierra
    sha256 "150e028a01c39c8197ba0844422e70e8c2bc959d0904d237d5351e93c38f37c8" => :el_capitan
    sha256 "7e7d1a84ebb18b405bb912f13d16889077c31aa50080b015ecf7c69e150cf4f3" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
