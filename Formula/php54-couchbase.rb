require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Couchbase < AbstractPhp54Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.0.tgz"
  sha256 "1b7d7fe32c648bff20918ed437eca848c9dc2432198a77051b46a7373e8bbc8b"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "214c3ea38e8c496a4990ac6206cc1448517828a65fc179a89db7141ec1b7adc0" => :sierra
    sha256 "6db6dd9dd8bae9c001043ffa4c8e732051d7ecb31b2a4bc347485b8406d882a3" => :el_capitan
    sha256 "fc8c54b05b9f78e67c33aa06b8479158e47d64b0941e7ab1b560128148fc313f" => :yosemite
  end

  depends_on "php54-igbinary"
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
