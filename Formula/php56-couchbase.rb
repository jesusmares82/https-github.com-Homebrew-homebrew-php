require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.1.0.tgz"
  sha256 "30eda3f5afd0d9f4c77b12650163c3490de111e57ad6b20092c95e44e3d60a8d"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    sha256 "173447213519b7b9ee5971ae21f9181e31ccd56f9af891bf8bee5c2f269c9b3e" => :yosemite
    sha256 "55822d6b1a62c803a5030fdcc15819e8b82946417bf634f27be65adf13797994" => :mavericks
    sha256 "171eb56d2e459d03508d2205780a0b49c5ad2845be68ab8207bc3e3208590b5e" => :mountain_lion
  end

  option "with-igbinary", "Build with igbinary support"

  depends_on "libcouchbase"

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
