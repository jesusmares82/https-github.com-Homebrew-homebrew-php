require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    revision 2
    sha256 "2d2e86830015eab368a2660c11e153e5c233ed0999eb8854411cd6d8dddd5433" => :el_capitan
    sha256 "9dd71cfbd5c36ef613ba364811fc4822318f1e171e78e73eacb3dea8a13ad78a" => :yosemite
    sha256 "9923a287f831b167c7cd28912e634654bebd15b6baadac3dd66f0a7c4fb1ecdb" => :mavericks
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
