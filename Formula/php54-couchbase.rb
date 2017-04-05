require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.1.tgz"
  sha256 "d9c70bcf6f65626dfe7e51a0527fea35cde28145f74a0ddbf41a64d395f7a493"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "041288be4ca13e9fb87099d80dd67bf0fc46167300839ef782bcde0762e66fa4" => :sierra
    sha256 "5b5dcd7b0a8c6de94d08bd97d048e4d2cd0214fff5eaa4a0e1b97a6c41b0da6a" => :el_capitan
    sha256 "8a012c298df42fb194f4d82ef0fa87e2c01a65cbc110671a65f70c633e76497f" => :yosemite
  end

  depends_on "php54-igbinary"
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
