require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Http < AbstractPhp54Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    sha256 "6d8604bf3c4b2673993b9790c464348c6c0d63c929a6bc1ba8e2e5e5c4a7c984" => :yosemite
    sha256 "d23cbfdad6434ab9e38eaa79ced628fd70c356963af55470271d5d2a12d5719d" => :mavericks
    sha256 "f7a4e45f81935cb9a62d35673fed3d09a816ee4d99ce684e52ffcf3c56071148" => :mountain_lion
  end

  depends_on "curl"
  depends_on "libevent" => :build
  depends_on "php54-raphf"
  depends_on "php54-propro"

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
    cp "#{Formula["php54-raphf"].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    mkdir_p "ext/propro"
    cp "#{Formula["php54-propro"].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

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
