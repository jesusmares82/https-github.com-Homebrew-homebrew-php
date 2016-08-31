require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geos < AbstractPhp55Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0rc1.tar.gz"
  version "1.0.0rc1"
  sha256 "63721d9dc2051aa03034b343c0b334e9cb11643e7009ea9be2e69f51f7b90f71"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "2f158b670c51c6426bac7d38ede48826f6f0b9096eb4d891d49dc6a67272d0ae" => :el_capitan
    sha256 "da734783b3fa2507d036e12b0cfb920bf2d0b05873ed3c4c83a770d88836fa11" => :yosemite
    sha256 "6839c6028f165cf7410e2863fe632ff3550b44e7ca1a25cc75655e6a13eafee8" => :mavericks
  end

  depends_on "geos"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geos=#{Formula["geos"].opt_prefix}"
    system "make"
    prefix.install "modules/geos.so"
    write_config_file if build.with? "config-file"
  end
end
