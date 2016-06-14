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
    sha256 "2d5af129bc7cb37df171376254f0cd267e5f11a9ed3b44689b170e46b814f920" => :el_capitan
    sha256 "61a38ce10464a58d857bb9d449a19e22933dfae66ca12687a3c2d0e5321af5d0" => :yosemite
    sha256 "b0a4c2947c7f91514c0b5fac71f315320a0c880cbff084a44030ddaaf63dbe1a" => :mavericks
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
