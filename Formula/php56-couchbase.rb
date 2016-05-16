require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.1.0.tgz"
  sha256 "30eda3f5afd0d9f4c77b12650163c3490de111e57ad6b20092c95e44e3d60a8d"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "7973f87cdd936b07b50c807ba49d41703e818fa1ffadfe000c92050c6b16a96c" => :el_capitan
    sha256 "2769243a4fe93cad0101b4a33c846bbd6816daed2d621d4ee9d4bfea4c9fbb07" => :yosemite
    sha256 "59cb92c8534ffa3dcc4fe1bfa5238f3603aee82c1da352606d032c618eccc7b5" => :mavericks
  end

  option "with-igbinary", "Build with igbinary support"

  depends_on "libcouchbase"

  patch do
    # backport https://github.com/couchbase/php-couchbase/commit/916d4b7f6c31f03662b43e9e8cd08500087aae1a
    url "https://gist.github.com/avsej/4f0bc3d1fe5da95688ea6a5ae41764c5/raw/59b3b109dfb6e594334778789ae6b10824cc39c6/916d4b7f6c31f03662b43e9e8cd08500087aae1a.patch"
    sha256 "1725b49b0737f2b65c1f30a5308be91cbb552e1d119b726ba7e130fe6c03ac97"
  end

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
