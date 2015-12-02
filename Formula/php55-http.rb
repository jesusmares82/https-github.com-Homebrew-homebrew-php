require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Http < AbstractPhp55Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    cellar :any
    revision 1
    sha256 "c2779d72892db99617bb8c76d15e581af787a9c0c76874e277a977054031eb1c" => :el_capitan
    sha256 "cf8a5098ecbcb2fb77b41390ded8bc5430a6b5b735e1915231de908b86005bf6" => :yosemite
    sha256 "6084b7d3335400b66147c2b2e58e8b943a4fda7b53281ef86b9112abc0880fd5" => :mavericks
  end

  depends_on "curl"
  depends_on "libevent" => :build
  depends_on "php55-raphf"
  depends_on "php55-propro"

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename
    "zzz_ext-" + extension + ".ini"
  end

  def install
    Dir.chdir "pecl_http-#{version}" unless build.head?

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
