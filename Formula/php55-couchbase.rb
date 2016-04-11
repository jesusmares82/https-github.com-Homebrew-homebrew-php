require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "https://pecl.php.net/get/couchbase-2.1.0.tgz"
  sha256 "30eda3f5afd0d9f4c77b12650163c3490de111e57ad6b20092c95e44e3d60a8d"
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
