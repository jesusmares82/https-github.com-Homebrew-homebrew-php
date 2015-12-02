require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Http < AbstractPhp53Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    sha256 "464143f1f16fa53bdb07444a8a46d47953b8d1ce592801afc7b57ea357f21505" => :yosemite
    sha256 "7832b9709ffc04f0fc5b0d823542c62105ce95c7b8b146ba01ab84a5666e9240" => :mavericks
    sha256 "e66de4ef6e6e5c77f8657e27c3f6eb2c26d30b6b3e29ec5fdc52fc074357351d" => :mountain_lion
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
