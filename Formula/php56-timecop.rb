require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timecop < AbstractPhp56Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.3.tar.gz"
  sha256 "c77d6d1f4e67e7730e88556257ba16e25028b5c4a008a22ea670ec6d29d42fb4"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1e705236cfee340e4e846a0369e633f14f5b8b4ca0ba0153326a0d3350f9e601" => :el_capitan
    sha256 "7331e793943d9a8f4aff9d25e9cb521c8b62dd50fdda9a3f6984fdf58885f5ef" => :yosemite
    sha256 "f33f65acce2682acae3930ce8acfb3046b0eb903998b1df028185155b36bebc9" => :mavericks
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
