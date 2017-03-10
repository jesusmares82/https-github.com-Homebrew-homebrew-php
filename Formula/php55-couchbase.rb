require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.0.tgz"
  sha256 "1b7d7fe32c648bff20918ed437eca848c9dc2432198a77051b46a7373e8bbc8b"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b5af09da46550824ebe362f3ef5b5c55babbee5e68c6aa881821682cd0b61703" => :sierra
    sha256 "a74b263a542df5da8f44d90fa527cb498fd1fea51567d9397bce58ea75c9e722" => :el_capitan
    sha256 "2858bdd8b97351116838dff74b5efc41c7dc361db33d9da246dde09d790597a6" => :yosemite
  end

  depends_on "php55-igbinary"
  depends_on "igbinary" => :build

  depends_on "libcouchbase"

  def install
    Dir.chdir "couchbase-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
