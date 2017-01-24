require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Geos < AbstractPhp71Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0.tar.gz"
  sha256 "09cd4e7a3b026f65d86320b1250d6d6ceb8d78179cbfd480f622011d52f92035"
  head "https://git.osgeo.org/gogs/geos/php-geos.git"

  bottle do
    cellar :any
    sha256 "b8cfa302799f6fcf264a03f1af55621d47d4b5a45da18fea322bbd623337ea1d" => :el_capitan
    sha256 "a97ec63be5e253cb04a9603713b1534d677d24cdb8e94d6e191c6db329882e61" => :yosemite
    sha256 "e8e6039d13c45a3c17cef05ff65189441a644d75559fac15195299e1076e781c" => :mavericks
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
