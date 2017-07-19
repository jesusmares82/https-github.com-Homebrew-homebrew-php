require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Couchbase < AbstractPhp70Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.4.tgz"
  sha256 "90af2271485ab6c9a2bc0f1ceac7d0e3a0165fb0b5a7aa73531990219b180cad"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "248cc9a1152ba4d917f962eaf6476e09efd57e18d5515664c46a03f2e553d40e" => :sierra
    sha256 "c74d2d42fbecba25f22579798e6048e23680c7ce1d2c9114ca45dcdb6d94ff10" => :el_capitan
    sha256 "73f991fa313d73fdda59afef25b07f5efe5603b786276f1e9cbcfb20e614a702" => :yosemite
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
