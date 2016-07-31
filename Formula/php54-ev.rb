require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ev < AbstractPhp54Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0f75e6bf9da5e00066d2f952cf006e9dd7b8f9ffea450f4610ac6905e13237c5" => :el_capitan
    sha256 "473aaf403bd69ff85c9ff1ce4abc23af56bb4539252b6e247a90d76c4cd0fea6" => :yosemite
    sha256 "bff99dc7bf3cf9a6748b655f43f35e7a5039ca9cda9a24e89875c712880f765e" => :mavericks
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
