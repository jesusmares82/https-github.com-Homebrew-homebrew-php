require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.4.0.tgz"
  sha256 "f687871027cb1dbbca4ebea8a3c1d8dbe0c0992dd757ed3ffbeae71e43386184"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "c5c715b01c397bd019bcc71f1d9442bfda71e6406ba596dd7282637ae2e1de8f" => :high_sierra
    sha256 "b440de85c33dd640bf705e4736971139539800323b7dd6fea5ac4fec8267e8c6" => :sierra
    sha256 "c82ce03710c63dc6302cf029fb0c9ecddab22c3cfd6feabb68421f59b2908e35" => :el_capitan
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
