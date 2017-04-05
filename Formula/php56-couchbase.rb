require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.1.tgz"
  sha256 "d9c70bcf6f65626dfe7e51a0527fea35cde28145f74a0ddbf41a64d395f7a493"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5fb12c6d4b18e305656506afbeebc8123f3e4447c3e57c461101e90fe19faf1c" => :sierra
    sha256 "0c51a4320752d5ae23dbee10406ebac66cd02f598eb40729213f61033273ed33" => :el_capitan
    sha256 "8651f2da5dbdc8cd1729df0cdf3ab7b4901aa4146445cc30c75927f884c1e1a0" => :yosemite
  end

  depends_on "php56-igbinary"
  depends_on "igbinary" => :build

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

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
