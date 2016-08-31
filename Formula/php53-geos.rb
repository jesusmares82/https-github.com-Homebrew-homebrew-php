require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Geos < AbstractPhp53Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0rc1.tar.gz"
  version "1.0.0rc1"
  sha256 "63721d9dc2051aa03034b343c0b334e9cb11643e7009ea9be2e69f51f7b90f71"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "7319f2a25f1b56667db9653a5cd3a5fec4807515f145f78b08f9b116d1132e4a" => :el_capitan
    sha256 "fc5d1341ac80716d5f112c4cb4b8ceb0e266ec2d65660d2870a20c68a0517bce" => :yosemite
    sha256 "5c78057e302c0ce10d1a1ba7fb03866ed429666f798d331776e9d4e045dfc3b3" => :mavericks
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
