require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Geos < AbstractPhp70Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "0feff4d552072da0713bfd30f4d36be63e847bb80514b69cb1a5538c16b308c9" => :el_capitan
    sha256 "c102797750a3b26ce7837d350a81268cc91b688acb783830bc5ad959e06fd6f1" => :yosemite
    sha256 "44525fcde4aa664c7adce925c9816d42593fa81169bf5b43ff939a8c57d8c756" => :mavericks
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
