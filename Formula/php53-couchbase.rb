require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Couchbase < AbstractPhp53Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://pecl.php.net/package/couchbase"
  url "https://pecl.php.net/get/couchbase-2.2.0.tgz"
  sha256 "6ce11f344bd01df7e8b96894ea3db44e72a273633d67f80dbc130147cc161acc"
  head "https://github.com/couchbaselabs/php-couchbase.git"

  bottle do
    cellar :any
    sha256 "48793f38f70a82b074b59b51790bfd510afd59b63ab6ae877b9002a3c6af0c0b" => :el_capitan
    sha256 "67cdfc1ed57b62ab8457c8a52f04476f11603a990e738ecf349f4ef65d9afb61" => :yosemite
    sha256 "d039766e61d6ac1ae921b304be83516315288d5c07ee3f3e1ffc33bc06669b34" => :mavericks
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
