require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.1.tgz"
  sha256 "d67c0fd19fdcaa72720d4910e29db12ccd72c30c4f441e5f1d9ef204fd7bc3d8"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "7ffeabb0c7715fdcf276002ee89beeedc88f596d0adb109957ab26c4602b07cc" => :el_capitan
    sha256 "7ea96ad6359f46e0f5cb271bc2c0ce28efc86a46d38bc0b7a682aa80536636bd" => :yosemite
    sha256 "4680ad0523d36174ced2282ab0ff6419e2d619042c60074e650a96f671674e7f" => :mavericks
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
