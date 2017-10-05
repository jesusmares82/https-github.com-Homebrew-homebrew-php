require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Couchbase < AbstractPhp72Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.1.tgz"
  sha256 "1b455ffd27c2e0a7e67796d2a3536a1d8cfa729301eba399fe466ca69f49469c"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "cb64eb3151c9efbbfee4db1879aa8ee1b528bd5317f341a96cd16a1631223515" => :high_sierra
    sha256 "a4d82f91fc0ef9072f167e37dc442605387f22a7517afd6549535cf11e9140f4" => :sierra
    sha256 "a4e3ce6ba111a30d016a7d5db7aad6e03482943e5e519c55e74afe13f869b033" => :el_capitan
  end

  depends_on "php72-igbinary"
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
