require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.2.tgz"
  sha256 "17e76335c60e1673e7d86189d5dfd8d1482e1266e89db53894d671ccb3052f42"
  head "https://github.com/couchbase/php-couchbase.git"
  revision 1

  bottle do
    cellar :any
    sha256 "885c398d5d60321487a69a750c6cf55c428612d42f71c0df11b325de40fff3f9" => :high_sierra
    sha256 "44243dd9781a3d7fea8adb363a7df4400564aaa8cc7b29c5dc505e1f0f078152" => :sierra
    sha256 "2ea84916006116b358a83a95728516104cb2cd1f9d431df013de6aca88bb4ea0" => :el_capitan
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
