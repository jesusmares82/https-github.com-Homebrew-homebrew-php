require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Http < AbstractPhp71Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    sha256 "30baa58757262a928c9ba25a25971786d984733c019333d1656a97e77b0d720c" => :sierra
    sha256 "e43f3be7a7197e10b1cff09bee61fb21bf280c51c53806faa4b3026d8eb1fa0e" => :el_capitan
    sha256 "59eb6e159406d67e1a13d0eb438af9244742071888f4f372306c0bdddc092f04" => :yosemite
  end

  depends_on "libevent"
  depends_on "php71-intl"
  depends_on "php71-raphf"
  depends_on "php71-propro"

  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php71-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"
    cp "#{Formula["php71-raphf"].opt_prefix}/include/php_raphf_api.h", "ext/raphf/php_raphf_api.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php71-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"
    cp "#{Formula["php71-propro"].opt_prefix}/include/php_propro_api.h", "ext/propro/php_propro_api.h"

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
