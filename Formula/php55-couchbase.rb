require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.1.0.tgz"
  sha256 "30eda3f5afd0d9f4c77b12650163c3490de111e57ad6b20092c95e44e3d60a8d"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    revision 1
    sha256 "460dae86b6889f191f6abe13254f1115948d016ea42ef0cd60b2ca9584cc9dd1" => :el_capitan
    sha256 "97175f71df793580f18a15dc5d61aba4f6dbe8d7ed5e2c8890f588d59cb32128" => :yosemite
    sha256 "0fe94b89dc8eaccdb7978a4ee4cafb51f351bc4a03f633795662af04dd44655a" => :mavericks
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
