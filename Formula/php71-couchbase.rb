require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.2.tgz"
  sha256 "17e76335c60e1673e7d86189d5dfd8d1482e1266e89db53894d671ccb3052f42"
  head "https://github.com/couchbase/php-couchbase.git"
  revision 1

  bottle do
    cellar :any
    sha256 "177585852a20372fbaa6c95c76dcb00f34eec9a3055b0a774ea167e017a471b0" => :high_sierra
    sha256 "1ec144d56707c7d8486741eaa4462b776b043e5f9c60e45f02f264b809846e94" => :sierra
    sha256 "9fa0d3ad0e93d9479ef983de88fecbb57f102b1bcdb3d12e8aae93c363931de5" => :el_capitan
  end

  depends_on "php71-igbinary"
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
