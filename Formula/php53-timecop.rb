require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timecop < AbstractPhp53Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3994fe62abb70fc6faa95be54497783fdf6a749e8b7928953c1b87417a0790e1" => :sierra
    sha256 "e6cff48a260998045a835144e0efcaf6f7034552adfebde2b303eba0b9443b1e" => :el_capitan
    sha256 "48e4c367b579f039a65f3cde09850cafcfd7fd72a2c5594c5f0046b3fbeba4ed" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
