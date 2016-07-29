require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.0.tgz"
  sha256 "6ce11f344bd01df7e8b96894ea3db44e72a273633d67f80dbc130147cc161acc"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "206539c939487b50ccd009332408ab0e1fec341d735d3d204c20feda6bb2baef" => :el_capitan
    sha256 "b446e4f8ba8df517ec9e371ac29cee3e7650acbdaf067e5b132406e9bdab8656" => :yosemite
    sha256 "f1c7a413529d9372bfc73d01ee9d218836727480f99fc2f15b407b0cdaa3c4c2" => :mavericks
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
