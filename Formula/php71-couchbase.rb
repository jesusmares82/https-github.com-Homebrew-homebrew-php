require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Couchbase < AbstractPhp71Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.0.tgz"
  sha256 "1b7d7fe32c648bff20918ed437eca848c9dc2432198a77051b46a7373e8bbc8b"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a9d484d168f8dc43b4217f748765888bc6b238b94b60886661491b7e0c6c5635" => :sierra
    sha256 "b6b0f528a15b268adb67f577e1361738642df777b12deb038910af7baca2e4d6" => :el_capitan
    sha256 "caf6d19bc98cb823c6935a52cd33c43ef02f4e839a5ff3c746cb54947dd04a47" => :yosemite
  end

  depends_on "php71-igbinary"
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
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php7" => "igbinary"

    system "./configure", *args
    system "make"
    prefix.install "modules/couchbase.so"
    write_config_file if build.with? "config-file"
  end
end
