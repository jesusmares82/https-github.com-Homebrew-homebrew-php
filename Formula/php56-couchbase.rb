require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.1.tgz"
  sha256 "1b455ffd27c2e0a7e67796d2a3536a1d8cfa729301eba399fe466ca69f49469c"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "f1df841119e41a7c84862dcbf8bbe235b8f40c1e9253bf5be9a2ff52a69a3d62" => :high_sierra
    sha256 "ade67ade52aaefc77f132f36b9643926704d882780241e1bf0e48163ec9a48b4" => :sierra
    sha256 "9ad002e1466832b246b136a06b69ec331b1b47a8fc9c40c94b331227f80fe3df" => :el_capitan
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
