require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 3
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "6bbfcf6b1d4036ff3e6494400aeb8c5a537660e4a818af18adb55c657eb5855f" => :sierra
    sha256 "c120fb03d898981eaef002da051a19d28be212419da8dc4e2e3587a8b8add71b" => :el_capitan
    sha256 "591c4fb28ad067a1781ad051a4610be82f38dc5032257d9e8002823c78749e83" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php56-imagick"
  depends_on "pkg-config" => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
