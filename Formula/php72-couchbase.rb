require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Couchbase < AbstractPhp72Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.3.tgz"
  sha256 "98c0d7acf6dd1b3930c25f8902decc98a334891736e460124557065e720d7a96"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "07df903defa58d48e40968bf08c24449011304f772ebe0b9c69e791095b10da8" => :high_sierra
    sha256 "b4a983ec42706ae5d19360c082cd88061835699f614ff80ab9237901a576429f" => :sierra
    sha256 "61af687abba7f648bc06b63521203ef08f116d4c126d3b1959ad83763deac1c9" => :el_capitan
  end

  depends_on "php72-igbinary"
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
