require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Http < AbstractPhp53Extension
  init
  desc "HTTP extension that provides a convenient set of functionality"
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_2_5_6.tar.gz"
  sha256 "83c15492ae7673404db462b642450f5bec81db72765d21fbb915ac39a42f0be4"

  head "https://github.com/m6w6/ext-http.git"

  bottle do
    cellar :any
    sha256 "d90039784508c99caca68fc831982282a75a496d13f183a3f2e9a73f9c7797da" => :el_capitan
    sha256 "d0d2bef52197f0443de598472bbbb9c435c1543b1b93a98d0d5b0f9c39a6e789" => :yosemite
    sha256 "b37b2010d6939c6e3d4ee9297d644b7fff685f0ed25bdb59c83f1ab94e8b5138" => :mavericks
  end

  depends_on "curl"
  depends_on "libevent"
  depends_on "php53-raphf"
  depends_on "php53-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    mkdir_p "ext/raphf"
    cp "#{Formula["php53-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php53-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

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
