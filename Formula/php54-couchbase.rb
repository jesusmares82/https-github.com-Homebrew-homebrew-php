require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.1.tgz"
  sha256 "d67c0fd19fdcaa72720d4910e29db12ccd72c30c4f441e5f1d9ef204fd7bc3d8"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "97a89c7c110e266e819bbf3c8f6b0e4b56db5617657aafed1bb71d2c6105b819" => :el_capitan
    sha256 "dd98ce6c01866395890fadc69160e7c7063cb3a79593e37a5bb98f9f7c75f67e" => :yosemite
    sha256 "d92488d8ce4b76930b63fbc39e6d40dd7a37e1f44d9419214c67941aa5766c68" => :mavericks
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
