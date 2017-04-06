require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timecop < AbstractPhp71Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.3.tar.gz"
  sha256 "c77d6d1f4e67e7730e88556257ba16e25028b5c4a008a22ea670ec6d29d42fb4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce52cd1d7d352d500d069d3b26f77fc34f6c416d9125a9039e4e60b117e692d0" => :sierra
    sha256 "b00548bc3e0385f0d73575aa11ae9f324e1bb64e3f583959c325a35993c544bb" => :el_capitan
    sha256 "86d3ce24323dcf8e0f8de909d60780f0b6f5e7ccecdb92e3a4c3a18df3a7212c" => :yosemite
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
