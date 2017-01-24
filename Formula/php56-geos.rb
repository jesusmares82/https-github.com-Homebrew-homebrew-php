require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geos < AbstractPhp56Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
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
