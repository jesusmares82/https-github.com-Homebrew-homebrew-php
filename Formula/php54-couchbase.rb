require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.0.7.tgz"
  sha256 "0482757d6b29ec5b9c957b053203a75410ced519f2407e666f7ca5c180a66ff5"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    sha256 "8439385cb0de076008e37ea6dcea1d124e9f4c3917abe35cd519bdb4121c1a7d" => :yosemite
    sha256 "ff47cad93935eb564e7157a850dc25b502f2e1057763a011f5b8f91d3be1d06b" => :mavericks
    sha256 "6f4652f69cb4fc452f7e46d90b62a4678b19f225425a4b4ad3c3a6cdef907335" => :mountain_lion
  end

  option "with-igbinary", "Build with igbinary support"

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
