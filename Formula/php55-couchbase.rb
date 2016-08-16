require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Couchbase < AbstractPhp55Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.1.tgz"
  sha256 "d67c0fd19fdcaa72720d4910e29db12ccd72c30c4f441e5f1d9ef204fd7bc3d8"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "56e609af00ae84446e128099852e6c58dbd3559fc51fe748250d4e5a192851b8" => :el_capitan
    sha256 "252ed44c0308ec065802cf9c069648fb39ccadbf1356a219aed44d90243c6f44" => :yosemite
    sha256 "1c02e1f741ac6bf53039fadc6ad7208d1ecd5d43c6138479f5110e21cc54558a" => :mavericks
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
