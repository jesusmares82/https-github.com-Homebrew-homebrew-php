require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.1.0.tgz"
  sha256 "30eda3f5afd0d9f4c77b12650163c3490de111e57ad6b20092c95e44e3d60a8d"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    revision 1
    sha256 "f46bb54d33a2aad472e6920f67c096661e0c9bb7b562934d7c5f97724f07b742" => :el_capitan
    sha256 "fba1287dc317c914650378083d975009c8de3888a45d35a3ec72bf7dfcb6c31b" => :yosemite
    sha256 "ae24386a4e3ed711d30a6c4b319bb44b723a25bb37c52fc40d33c1702d1c24c6" => :mavericks
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
