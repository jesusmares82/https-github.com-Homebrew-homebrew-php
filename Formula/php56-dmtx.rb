require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 5
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "96b3cf85f6196936fb36b63551aa3ade0cfb1897441fbbb017c710633e17a7eb" => :sierra
    sha256 "33b1780fe459de6fecd766f7941f3222be95cdcc77530cf01372b236ced5238a" => :el_capitan
    sha256 "576199a7dcc8020b93c83199160d0af0556888828761c21d7996487e447c8a41" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php56-imagick"
  depends_on "pkg-config" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
