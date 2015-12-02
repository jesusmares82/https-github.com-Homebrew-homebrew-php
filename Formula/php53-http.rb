require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Http < AbstractPhp53Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    cellar :any
    revision 1
    sha256 "0f650832df2f4892e37e9505a98252ff3690b98e98bd9d6f5865b3fbe8815b2a" => :el_capitan
    sha256 "e95b18af7b09a2ebaf780a8b6be62a3db58e5a2e35dc3dc9f9fb4f4de5b28ead" => :yosemite
    sha256 "56df2f12ea40ce7d52987a6e0d4700cdf717fb6ba498357155b13e5c804afb59" => :mavericks
  end

  depends_on "curl"
  depends_on "libevent" => :build
  depends_on "php53-raphf"
  depends_on "php53-propro"

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
