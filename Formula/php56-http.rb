require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Http < AbstractPhp56Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    cellar :any
    revision 1
    sha256 "ae7e1b7eb889ba530bd3c49b6449d0d6c7da69a6bf2b8e4d194b4f2821de2ed3" => :el_capitan
    sha256 "43f77aca2e5d37519f747500f0d6b119777442b0a506294ff0724b3b2dd04b14" => :yosemite
    sha256 "dabed79204a2c8a41c61a32f1587b094f58ec4fad481b6c08d6f97dfa7091773" => :mavericks
  end

  depends_on "curl"
  depends_on "libevent" => :build
  depends_on "php56-raphf"
  depends_on "php56-propro"

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
