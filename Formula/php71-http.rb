require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Http < AbstractPhp71Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"
  revision

  bottle do
    rebuild 1
    sha256 "2039e8f50fc0db46a9a625b8820c8fe11772168c07260c663b246b9660d24f8b" => :high_sierra
    sha256 "c401dc5b3b3baa1f752e31d29efe731cb0455220e80d8853a1059f9e0c457eab" => :sierra
    sha256 "5e57fa565e7312ff2c2fdc552c161dbd7dd9a8c82062593e8f9ab332ee44802c" => :el_capitan
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
