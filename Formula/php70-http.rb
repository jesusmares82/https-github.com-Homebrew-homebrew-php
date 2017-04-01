require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Http < AbstractPhp70Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"

  bottle do
    sha256 "0fcb8213d5d934f5a1c41fdb1a492d0cd72a0a52213e0c0f8ffb5c362b5b85e6" => :sierra
    sha256 "87c97ac475bc33b4208aff16dab4dd287379f13b5a4fdde63760f78bbd8a6ad9" => :el_capitan
    sha256 "fa96d6f0bfc845d946747bb4c705e1c2a818719405d086610adc77a266bcb45b" => :yosemite
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
