require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Geos < AbstractPhp70Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0rc1.tar.gz"
  version "1.0.0rc1"
  sha256 "63721d9dc2051aa03034b343c0b334e9cb11643e7009ea9be2e69f51f7b90f71"
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
