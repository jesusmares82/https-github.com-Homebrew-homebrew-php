require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.0.tgz"
  sha256 "f687871027cb1dbbca4ebea8a3c1d8dbe0c0992dd757ed3ffbeae71e43386184"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "e8388fcb525f226e277c747b86e01fa79e12cd02767ad0a1f8d8e3164959078a" => :sierra
    sha256 "3d9143956dcc3376befa81e0915da661ef67d9c388e83a7b566988c7d51bdc04" => :el_capitan
    sha256 "5d69af80a9a3d075cef8b4c8da5e1b7a395a01b47335e6fb60a0843dc0ee8a7a" => :yosemite
  end

  depends_on "php56-igbinary"
  depends_on "igbinary" => :build

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
