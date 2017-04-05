require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Couchbase < AbstractPhp70Extension
  init
  desc "Provides fast access to documents stored in a Couchbase Server."
  homepage "https://developer.couchbase.com/documentation/server/current/sdk/php/start-using-sdk.html"
  url "https://pecl.php.net/get/couchbase-2.3.1.tgz"
  sha256 "d9c70bcf6f65626dfe7e51a0527fea35cde28145f74a0ddbf41a64d395f7a493"
  head "https://github.com/couchbase/php-couchbase.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f4d8ba2eade582a93b6e6d9d84d2749a5cd5bb366b2fe6e1e3f83f58f0f4057" => :sierra
    sha256 "cf13edb17b530daa06cfeba66dd0ed0e744fabf2d05da381cda31b1e3f11929c" => :el_capitan
    sha256 "4e653550d231350eb97866db9d0b8974de6d7288893f9cf0746dc670f1fa3ab4" => :yosemite
  end

  depends_on "php70-igbinary"
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
