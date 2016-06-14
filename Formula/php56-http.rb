require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Http < AbstractPhp56Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_5_6.tar.gz"
  sha256 "83c15492ae7673404db462b642450f5bec81db72765d21fbb915ac39a42f0be4"
  revision 3
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "f37b02e0eaf9353b692333f1d65cc0b2dc92a6865e16504b59905e299f826703" => :el_capitan
    sha256 "063e7613a414860a5fa1cade6f33bd22b4de4e40d027f1f88e09bd45ecfe3d11" => :yosemite
    sha256 "7237487f80a8bdfaf0375828704d244f9d6826edc2f0a0f6db9b42c6a2476b66" => :mavericks
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php56-intl"
  depends_on "php56-raphf"
  depends_on "php56-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php56-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php56-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

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
