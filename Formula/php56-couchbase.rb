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
    sha256 "ff5c533410ddaaa44033212d39d1bed606a41f8cb7d5997d04e1f1a6285c445a" => :high_sierra
    sha256 "0ab8a9b8af3ab6f6ce1817dcf4050d9fbe02f6e2b43149a3a7370640ce13638b" => :sierra
    sha256 "8217cc5ed0cb56699cd20ab92e4843da5a81b341a2bf68b06113cc7a92f4b77c" => :el_capitan
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
