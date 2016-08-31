require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Geos < AbstractPhp71Extension
  init
  desc "PHP bindings for GEOS"
  homepage "https://git.osgeo.org/gogs/geos/php-geos"
  url "https://git.osgeo.org/gogs/geos/php-geos/archive/1.0.0rc1.tar.gz"
  version "1.0.0rc1"
  sha256 "63721d9dc2051aa03034b343c0b334e9cb11643e7009ea9be2e69f51f7b90f71"
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
