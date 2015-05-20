require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  homepage "http://pecl.php.net/package/couchbase"
  desc "Provides fast access to documents stored in a Couchbase Server."
  url "http://pecl.php.net/get/couchbase-2.0.7.tgz"
  sha256 "0482757d6b29ec5b9c957b053203a75410ced519f2407e666f7ca5c180a66ff5"
  head "https://github.com/couchbaselabs/php-couchbase.git"

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

  test do
    shell_output("php -m").include?("couchbase")
  end
end
