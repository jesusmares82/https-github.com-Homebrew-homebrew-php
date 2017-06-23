require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timecop < AbstractPhp56Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d760a4200fd68198fd5ac12b9cf11bc49228347a9922372dc99e1ec59338562d" => :sierra
    sha256 "0a9d5bc476d74e48fb244ad6e7616761add16ac1f959295ea086132419eb7e76" => :el_capitan
    sha256 "ef6afb63c817919e7325e974497b67dcef3403111500987fc7b30a93a5cc8e51" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
