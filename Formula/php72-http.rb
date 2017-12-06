require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Http < AbstractPhp72Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_3_1_0.tar.gz"
  sha256 "6b931205c1af59bba227715dd846b1495b441b76dabd661054791ef21b719214"
  head "https://github.com/m6w6/ext-http.git"
  revision 1

  bottle do
    sha256 "7f9236272ef6099247a811c7c90466a1d42efb323f0719c2df974fe5a170e64d" => :sierra
    sha256 "8cafbec70bf00e81d5103ac72da07a5315db44ca73bb54a0fb387479bc36afbe" => :el_capitan
    sha256 "9fa112434ac25db68e75fa1d727f2d7557a50789fabdc347b3250877f30902ed" => :yosemite
  end

  depends_on "libevent"
  depends_on "php72-intl"
  depends_on "php72-raphf"
  depends_on "php72-propro"

  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php72-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"
    cp "#{Formula["php72-raphf"].opt_prefix}/include/php_raphf_api.h", "ext/raphf/php_raphf_api.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php72-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"
    cp "#{Formula["php72-propro"].opt_prefix}/include/php_propro_api.h", "ext/propro/php_propro_api.h"

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
