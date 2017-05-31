require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.3.tgz"
  sha256 "9f788f31b2928d6a2114dcf588926a32b5d8ac1fc2450fd185a9cca511c19ee3"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "3a2aa3a9bcd023bb21fb8eb1175cc4702b632fff8300cc89aa24dee96b28c615" => :sierra
    sha256 "e69a7cf527a973c9385485e00539d273c910148c81625321bf4a46c459974a6b" => :el_capitan
    sha256 "8b0cad0662e74571665920af7ecadda752ba5af8088df80cadc866042e37c4c3" => :yosemite
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
