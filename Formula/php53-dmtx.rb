require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    revision 2
    sha256 "05c333fa5eda8d162f45fa6d80642cbcbb5e064ce6730be27c7385c9a53a75b4" => :el_capitan
    sha256 "329541c4918cf99b4ffef13ed51a0c71af4c9f713992661bee93bcb5c540481b" => :yosemite
    sha256 "8736b0463aa9ecf0e5c35b78f4f58b5c78c433db1a4126987213e9245631de52" => :mavericks
  end

  depends_on "libdmtx"
  depends_on "php53-imagick"
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
