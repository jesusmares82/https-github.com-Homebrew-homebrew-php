require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Couchbase < AbstractPhp70Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.0.tgz"
  sha256 "6ce11f344bd01df7e8b96894ea3db44e72a273633d67f80dbc130147cc161acc"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "357fbbfd7a9e5cc3c67500e37fb0f2461e6d97d7227ecf73f54fd1c6e394f1aa" => :el_capitan
    sha256 "36ca263a062993c8ed73700e94803f56182c76444c00e9e49ba0174f9e5e63cd" => :yosemite
    sha256 "777c804ec458db5236ccd567f051e195244647c8a310e9942552ab9d96565879" => :mavericks
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
