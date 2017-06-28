require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Geos < AbstractPhp72Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "962b1dea01fb4c1cbb651435052b718fb62dbed9094050857578faaf64940442" => :sierra
    sha256 "a2f71edf53a510007e272f1ed1a86624e13c1763c385e75442ebd1cd9687f8ec" => :el_capitan
    sha256 "368185cc7bc085c1257cecc8513afdc1010f147e6af59cf0da4a050e61f2288d" => :yosemite
  end

  depends_on "geos"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geos=#{Formula["geos"].opt_prefix}"
    system "make"
    prefix.install "modules/geos.so"
    write_config_file if build.with? "config-file"
  end
end
