require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.2.tgz"
  sha256 "e1c7fafb3d05904deb26613176eeaeb0bd8ed8a8d0f3f139c5ab40c6efa49897"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "de795fddc1f1f3d3ae6f3c201e906d0d72bf09d07d45f19efb6499b4d85b6ac2" => :sierra
    sha256 "ad98c6d3adfdfd360d9a8e8913e84fb98c5de3ea0ded96b50881b53bad9689d8" => :el_capitan
    sha256 "a5e4ea95d924fc09a9bc826fb6c51805bc4d5e6e0b117764f4f56d6b5c6e11c8" => :yosemite
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
