require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.2.tgz"
  sha256 "e1c7fafb3d05904deb26613176eeaeb0bd8ed8a8d0f3f139c5ab40c6efa49897"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "60993d36de9d3f52c12867892e93a1ea62ab1edbe1e85a1dae3eaaefac69b950" => :sierra
    sha256 "fec261ab3e6fbc3385d4f1494492ef93ceccc1b86b5e23c540338d5b66f2c419" => :el_capitan
    sha256 "13a8467f802e02466a1a15bb730c7fd5bd83986aeeefa0233943477916b6e993" => :yosemite
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
