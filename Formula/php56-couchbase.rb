require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.0.tgz"
  sha256 "6ce11f344bd01df7e8b96894ea3db44e72a273633d67f80dbc130147cc161acc"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "94ba5159b39bcddc1871d1f2ca9527a599494eb51af0bb43d31530ae2f7fce86" => :el_capitan
    sha256 "3643cb25132e4242e4a58f34f6a0200a91dc346e4882d40da4601f00b1f28dd7" => :yosemite
    sha256 "f060ff74455280a507e6a92f1d6a2bd779e909802ebb21b5d38f87cdcd6e1eb6" => :mavericks
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
