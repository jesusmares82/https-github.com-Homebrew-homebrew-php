require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"
  revision 2

  bottle do
    sha256 "35e32a0642544fda3a3ef5674b8a884cfc18a5aea45cbf7e8921879cbac95341" => :sierra
    sha256 "83801db3229fb91528ac65ffaaf9fed8591becb81a38e6834f6d655f433f811d" => :el_capitan
    sha256 "3fdf7944f287d4801893e824f1afc3ceb39cbe16aee7945afc8910711e12d550" => :yosemite
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
