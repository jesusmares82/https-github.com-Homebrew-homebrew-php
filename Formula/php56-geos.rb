require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geos < AbstractPhp56Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0rc1.tar.gz"
  version "1.0.0rc1"
  sha256 "63721d9dc2051aa03034b343c0b334e9cb11643e7009ea9be2e69f51f7b90f71"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "64825b8dee0f05ecbe9baf0a4df460dbbe8e27480ddfe60864551218eed8af71" => :el_capitan
    sha256 "0e050fb313aac7fb31c49b3320ebffc5b433898a65af5966161e68a860c3a100" => :yosemite
    sha256 "4db169bddde3447f10d2f9f3b314b7ee240b70fd5dd2d4ab213c29a7bddc85db" => :mavericks
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
