require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.1.tgz"
  sha256 "1b455ffd27c2e0a7e67796d2a3536a1d8cfa729301eba399fe466ca69f49469c"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "0e0da3f2b3f06d5518385c9e2fcacd0d1bc154f709dc23fb61cce05f1a72243d" => :high_sierra
    sha256 "a52999a97ff8daaa8454526a8283d33052f4ff88724f4e0a2a4fdd04b0aa7293" => :sierra
    sha256 "2206aaeb3a5e40363321242451d9f928175e20059b35ca6b3eb8eaec22129865" => :el_capitan
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
