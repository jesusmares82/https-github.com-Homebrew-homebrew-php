require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Midgard2 < AbstractPhp56Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    sha256 "b5fdfda206abcddce54e2d719c980d875b7ce049d89f11514d4f2fa3b1901c39" => :el_capitan
    sha256 "1d2d3d7193e08661f40c7d7b6dc3d84bb622d6ad4ff8728d5ab765f2f771764e" => :yosemite
    sha256 "0b9c1c7850806c8bf437bc8e5f5ca390395c0eba4e753331929c52441a321c06" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "midgard2"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file if build.with? "config-file"
  end
end
