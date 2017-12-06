require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Http < AbstractPhp70Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"
  revision 1

  bottle do
    sha256 "ba00e21f912e7ced734c5e26d4dcd6efe15beb02ee4fc7ac72a25f1b2e05fb5f" => :high_sierra
    sha256 "2da9a293b876cfcc67084a4ec71115bdbd3c591f5ac994525f250df2b344b1a1" => :sierra
    sha256 "dabcc71083cd1c14788da4d8d2fc73927bfa9d7fa56f9d74d66a02df0c03caf2" => :el_capitan
  end

  depends_on "libevent"
  depends_on "php70-intl"
  depends_on "php70-raphf"
  depends_on "php70-propro"

  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php70-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"
    cp "#{Formula["php70-raphf"].opt_prefix}/include/php_raphf_api.h", "ext/raphf/php_raphf_api.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php70-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"
    cp "#{Formula["php70-propro"].opt_prefix}/include/php_propro_api.h", "ext/propro/php_propro_api.h"

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
