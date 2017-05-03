require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.2.tgz"
  sha256 "e1c7fafb3d05904deb26613176eeaeb0bd8ed8a8d0f3f139c5ab40c6efa49897"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "8fbfe3e77187716184753533fc7369a22342022961357f279c3fd74dcfe117d3" => :sierra
    sha256 "a372e86a7c12889417f373ceb4f41e45bf9e3803ff6dd396e6cd2d6c4704ed9a" => :el_capitan
    sha256 "930dbfa832202698822d76c47013d051da553de37add7e17dd1d1dcfcc5f20e6" => :yosemite
  end

  depends_on "php54-igbinary"
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
