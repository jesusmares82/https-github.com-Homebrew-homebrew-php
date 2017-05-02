require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.2.tgz"
  sha256 "e1c7fafb3d05904deb26613176eeaeb0bd8ed8a8d0f3f139c5ab40c6efa49897"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "d8e5e2b89ba2204c17f634efa4b62016eb94a0023508b0bad14713cbbac06bfd" => :sierra
    sha256 "2c206c1b9f1c48f709f93af164b2d4f791afebdc3505ef7f0d6c45112cb74019" => :el_capitan
    sha256 "1f6bc3922a3eb799350b7778bddcb15fad5f9902bddd0961296431c9ffc55352" => :yosemite
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
