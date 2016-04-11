require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.1.0.tgz"
  sha256 "30eda3f5afd0d9f4c77b12650163c3490de111e57ad6b20092c95e44e3d60a8d"
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
