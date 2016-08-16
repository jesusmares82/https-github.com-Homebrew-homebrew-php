require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Couchbase < AbstractPhp56Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.1.tgz"
  sha256 "d67c0fd19fdcaa72720d4910e29db12ccd72c30c4f441e5f1d9ef204fd7bc3d8"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "47c8563fef4106de65c7b72257004f3d32ad9ccd303ace04f85d8ab8eb57d75b" => :el_capitan
    sha256 "2822416df97f9cb3bf967348d97670684c1d99b45c5079e756fead5c62fb8745" => :yosemite
    sha256 "ac0bd96ff446ebdeb8391017f98cce5cba3b3e834d5ea2476a643b2bc4ffb77f" => :mavericks
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
