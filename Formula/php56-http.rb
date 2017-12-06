require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Http < AbstractPhp56Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_6_0.tar.gz"
  sha256 "1ff7c8d9cbeae67837033ddff7032f4acdd0c7bda3e3f12a1ca80620d949a775"
  head "https://github.com/m6w6/ext-http.git"
  revision 1

  bottle do
    cellar :any
    sha256 "35fa46a54d33fca4a6208094d43ea5b6aade2ada7838f61f4df419e8016c6f60" => :high_sierra
    sha256 "0106216262a8a9988b4140a2c1688c08f99fa2ffd921f5075559fe1850f70bdf" => :sierra
    sha256 "e54bbdbddd0b0daac4ea61ab21ea7961abc0960fedefb54640473c649585ecd5" => :el_capitan
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
