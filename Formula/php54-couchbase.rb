require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.4.tgz"
  sha256 "90af2271485ab6c9a2bc0f1ceac7d0e3a0165fb0b5a7aa73531990219b180cad"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "7dea67f51fb7937e855eba4501040c0a62ab257f497130bdbd00a29095c3f518" => :sierra
    sha256 "bff77b0a4c299a0d8d8ed61154a71332deadd3f577e29997dd452101706b8f96" => :el_capitan
    sha256 "7693ca1494b748ffc5a596529936cccb1c35843d5b688ec0eb918d1e4e1924c6" => :yosemite
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
