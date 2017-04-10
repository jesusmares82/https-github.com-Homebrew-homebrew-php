require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Http < AbstractPhp55Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_5_6.tar.gz"
  sha256 "83c15492ae7673404db462b642450f5bec81db72765d21fbb915ac39a42f0be4"
  revision 1

  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "8bd161a3d2983558ebcf9a5a8d307ba44618527d4e65856268f52184219c0dcb" => :sierra
    sha256 "32b0489f67b17d43057841693c3677fa2b14248f2120c513bb66980469c2e3e8" => :el_capitan
    sha256 "48ebf439ad036b1a731afe3503163907be4e6e9b664fb3516e9d18d224550c46" => :yosemite
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php55-raphf"
  depends_on "php55-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php55-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php55-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

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
