require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.3.tgz"
  sha256 "9f788f31b2928d6a2114dcf588926a32b5d8ac1fc2450fd185a9cca511c19ee3"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "000bdf606f45bfd5acc3ee4af0852201d6b6d8eceec9bbe68352b0bd2eb5993e" => :sierra
    sha256 "fed95b236b07bf55f6f3350b12658870fef387e38f6fe69e8c24022bb77b2467" => :el_capitan
    sha256 "1b200151e6021590b65b1b1bf21dfec6f74509fe6398566c930c63a0ff326eaf" => :yosemite
  end

  depends_on "php55-igbinary"
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
