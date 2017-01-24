require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Geos < AbstractPhp54Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "0f49e69e47e663395f4d489db053ec34ce81d26b073cb809c96fe648b533a543" => :el_capitan
    sha256 "ab3729517fd9785a57bdee051fdc89729cbe4e04e47a033641fea131a6b4cba8" => :yosemite
    sha256 "a7b3e2419af3d206befb82ae15194d670fd588599fd3f0e1540b7b71f9440660" => :mavericks
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
