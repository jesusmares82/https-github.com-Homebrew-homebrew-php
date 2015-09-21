require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Couchbase < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.0.7.tgz"
  sha256 "0482757d6b29ec5b9c957b053203a75410ced519f2407e666f7ca5c180a66ff5"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    sha256 "717f813cd708ffef314a577c9d480cd200dc262ca522afc2af50f270940070bc" => :yosemite
    sha256 "2eeb9527a8858b689b49c674e8dcd61e96fa0d281b81a9dfe72e22c399bef39c" => :mavericks
    sha256 "2472d7847a65e8a269e66b707939a066da12b3522b0b6aa3fca4a1da284107a9" => :mountain_lion
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
