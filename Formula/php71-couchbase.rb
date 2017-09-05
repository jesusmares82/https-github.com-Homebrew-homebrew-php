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
    sha256 "62f577e6ca31191aaec8f877b0161e465a711602903c2002327040c644cde20e" => :sierra
    sha256 "774fcb9696512ca51e8b99a914784e5b259dfd2b8e44033459e89d5e8bd244cb" => :el_capitan
    sha256 "2222ce0d686d337aef106f7257a05c1ef22741dacb081f92a7885804c979e3ca" => :yosemite
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
