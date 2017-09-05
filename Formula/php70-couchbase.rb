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
    sha256 "a1a7324d31076c29e966380a4b6bf084df1fec08b08d3eb8b6c23369578ff12d" => :sierra
    sha256 "5ea2e917146a1f0e9af21ac6053db8e5af374532c2a0d44c37e8e3411fc573bb" => :el_capitan
    sha256 "4d5fcf5cfbecb029114d69ff7e3f1cff6ed3f6832e6fce10d96b2f85de2c17a0" => :yosemite
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
