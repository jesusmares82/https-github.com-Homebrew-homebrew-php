require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.0.7.tgz"
  sha256 "0482757d6b29ec5b9c957b053203a75410ced519f2407e666f7ca5c180a66ff5"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    sha256 "cf7dd3612e37ba67a2e00f6381052017548d4b2939784d1fd87f867e1321f388" => :yosemite
    sha256 "f1385be6ab91caa356c3fcb3e58c60f4214da04242b053b9bc9ea63f1f01a5bf" => :mavericks
    sha256 "4f136d35d416969c954fd31b998b8d0828684e8b2904deb2b8ee17b1db180a49" => :mountain_lion
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
