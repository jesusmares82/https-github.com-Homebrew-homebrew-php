require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Http < AbstractPhp56Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_5_6.tar.gz"
  sha256 "83c15492ae7673404db462b642450f5bec81db72765d21fbb915ac39a42f0be4"
  revision 4
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "205061810329ae8e9d254d2e7e332a3392f8f7b67cf06f2d655f66b7e69c6c30" => :sierra
    sha256 "566cd54077ec0155dad1f1d0254c605ec2b80f817e87a6479c207f21303040a8" => :el_capitan
    sha256 "87eca7ead4afb5ad11cf84f4afc4a8e44ccc41f1fe2f785130a2acdeef4289f3" => :yosemite
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
