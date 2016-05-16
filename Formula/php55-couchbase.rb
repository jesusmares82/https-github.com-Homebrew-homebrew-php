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
    sha256 "cec6c09e3a3159d0acd2b05bfb42e735a53806f8e10d6638be000974da4200df" => :el_capitan
    sha256 "3fbe0afa9feb00712a866c07bdeb9a8bab82343173ee6be27ac3c85722623f7e" => :yosemite
    sha256 "c0414aa54f18fa2ae08d351dddd405a629f0ed9de96d069107da63be6a4b69ae" => :mavericks
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
