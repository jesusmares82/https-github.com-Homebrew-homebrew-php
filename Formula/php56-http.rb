require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Http < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    sha256 "fcae5e477d6ac79bffbfd3afc56578602563bab331520150beb17de0b12aa1f4" => :yosemite
    sha256 "9172eafe53a7f71c5042765051150024b3482c0574404b14218c7277dbc87f8e" => :mavericks
    sha256 "6a3148b42c3a338da7e7aa8149433b16f94d219b0fea7a75b034d333c9f45411" => :mountain_lion
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
