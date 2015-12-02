require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    revision 1
    sha256 "62509cae701a0389e9c133068134f906220837fe17faf1899c0763217562ba1a" => :el_capitan
    sha256 "97391e8ad0f64acb6ae354136f1d88c4da90acffec4c04f859de073a3f9e0d58" => :yosemite
    sha256 "0f2e50b2ed1fe5a3ff56fc031efd42df2e4cd9f78b995ecc7b72d95a7a5ed8c9" => :mavericks
  end

  depends_on "libdmtx"
  depends_on "php55-imagick"
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
