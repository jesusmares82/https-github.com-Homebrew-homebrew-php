require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Timecop < AbstractPhp70Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.10.tar.gz"
  sha256 "43318cca7022783b1f815466e8e447cbcf0afa9f3bef008caee8446fad7f34c4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9b68b4e4e348734274d4c4029cd0c0561ccee2456569dcc683c2ee7a72521f55" => :sierra
    sha256 "cbc8e2285d70b5d26885c5fbc01b5767ac6e26cce4f4a485e55df39b1683b277" => :el_capitan
    sha256 "181d135b070a7a954bac9696360d8f6292a65346e66608d39e4d5b9d7a4e96d3" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
