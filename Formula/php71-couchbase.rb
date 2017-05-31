require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.3.tgz"
  sha256 "9f788f31b2928d6a2114dcf588926a32b5d8ac1fc2450fd185a9cca511c19ee3"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "3a3cc5ca961134b4033944e90acdba276b53543d1a750e35c4a207815469a727" => :sierra
    sha256 "26d52a9990e3c307e96f2eeb2628de3e602d6bcf88910380a631d3b8e9a3ea82" => :el_capitan
    sha256 "ca121f5c2d0533d55575d35d775b85add6abcf7e190048f1935ae36ae736368f" => :yosemite
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
