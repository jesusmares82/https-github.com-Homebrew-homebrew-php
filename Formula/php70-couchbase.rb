require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Couchbase < AbstractPhp70Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.1.tgz"
  sha256 "1b455ffd27c2e0a7e67796d2a3536a1d8cfa729301eba399fe466ca69f49469c"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "de05d82f99fbba0d48b39a839dabeb9b7b615cd742b5f292138615b931eae5b3" => :high_sierra
    sha256 "bccffe6802167dc778c8f5628ccc5ac6938622bdb4a20f6d2385eb1d803a3efe" => :sierra
    sha256 "0bb7751e59679ccdf6c6e22d9fb2cdc605abb89edd476f7bc688aa926dd5117e" => :el_capitan
  end

  depends_on "php70-igbinary"
  depends_on "igbinary" => :build

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php7" => "igbinary"

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
