require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Http < AbstractPhp54Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_5_6.tar.gz"
  sha256 "83c15492ae7673404db462b642450f5bec81db72765d21fbb915ac39a42f0be4"

  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "3776087de63940ebc6e861a3026473db9f20dc525e615cd54745acef2e8fa10e" => :el_capitan
    sha256 "17866e894fc3367484091a9bfce7d8f6596933982b70ecd00b33f531fc810441" => :yosemite
    sha256 "eeffab638cf76ac05b2dd27a32936e1a31e6c90c649ddf4ed540051eca042eea" => :mavericks
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php54-raphf"
  depends_on "php54-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php54-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php54-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent-dir=#{Formula["libevent"].opt_prefix}",
                          "--with-curl-dir=#{Formula["curl"].opt_prefix}"
    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"

    # remove old configuration file
    rm_f config_scandir_path / "ext-http.ini"
  end
end
