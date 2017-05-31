require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.3.tgz"
  sha256 "9f788f31b2928d6a2114dcf588926a32b5d8ac1fc2450fd185a9cca511c19ee3"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "4f7d60f13801f36eb84685f88eb114aae311d7c921b5e0ed38930001e3bf1214" => :sierra
    sha256 "fe273f500b312cc4037bb4b8c846a41849d171942abe5003e304ddc41aaa7325" => :el_capitan
    sha256 "187b677c6658741812219e407b88e3bb8557ae78bcbb18f64a9393dcb01ed8cb" => :yosemite
  end

  depends_on "php55-igbinary"
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
