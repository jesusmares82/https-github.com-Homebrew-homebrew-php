require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timecop < AbstractPhp55Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.3.tar.gz"
  sha256 "c77d6d1f4e67e7730e88556257ba16e25028b5c4a008a22ea670ec6d29d42fb4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7cc4ce9e4db46885cc116af85fce31f50d1eb247dd012cfb4b9110770147e655" => :sierra
    sha256 "dab3d0dfc31faeedf4b3acff536d02e8c92bf7496b70bdb2ca00b4ffb2171e3e" => :el_capitan
    sha256 "847b1e144fe77213cb27a5b1b3dca0b77c1b330858f5dca4ea22c758772638a0" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
