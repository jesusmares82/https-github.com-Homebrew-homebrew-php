require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timecop < AbstractPhp71Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.10.tar.gz"
  sha256 "43318cca7022783b1f815466e8e447cbcf0afa9f3bef008caee8446fad7f34c4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d373202a2061bbcfd50c3adcfd81e95e5f38dbf9d3f584158e1cd54bbd7ea4dc" => :sierra
    sha256 "2847cbc66769bd2fae714d44e7ced5707849f11dfd015d0b28de396813461486" => :el_capitan
    sha256 "bd204931ce81f73a939173c978e8c73f8992e30211035fb15c1637e740249d85" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
