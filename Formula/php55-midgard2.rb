require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Midgard2 < AbstractPhp55Extension
  init
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    sha256 "1b2b993938242b62ca4055d916af0e1e405291ca3dfd0e7a1b351902b211aef1" => :el_capitan
    sha256 "4c610ff49f03cdbdbf5ed2838c1726bbb788cf677a49ae419357ac1e5e5a3f98" => :yosemite
    sha256 "808bf9221e9c7fe15d98f34c793507bd444c086d2c43a9a3005249d4b07a1749" => :mavericks
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
