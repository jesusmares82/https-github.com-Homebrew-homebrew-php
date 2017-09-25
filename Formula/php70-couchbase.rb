require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Couchbase < AbstractPhp70Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.0.tgz"
  sha256 "f687871027cb1dbbca4ebea8a3c1d8dbe0c0992dd757ed3ffbeae71e43386184"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "85192e5e943c39646bdade15ddf5ef6108055b2fbb30aef250df0663e57933d9" => :high_sierra
    sha256 "4c3efbe97f33b90f9a0dc9a4bd32fe50f2c12fce0c03b0ed516db2189f275333" => :sierra
    sha256 "6eb5d2d9d29787c7e02cd9625a4b200a4df33e29bc467dfe1d5ecc964b25f2fc" => :el_capitan
  end

  depends_on "php70-igbinary"
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
