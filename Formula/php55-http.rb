require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Http < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://pecl.php.net/get/pecl_http-2.4.3.tgz"
  sha256 "2d9f3713331cf35b4a0162bd8b294683a67fecb5223e50978661acccd30c6c39"

  head "https://git.php.net/repository/pecl/http/pecl_http.git"

  bottle do
    sha256 "ca7a3adc8d60f0fc62245db7dfd21f11558a02265032571d7ad701046dd2c226" => :yosemite
    sha256 "64fc3f716294891bef099c9b4fe30ef7bbc248e2826a4334dad71af5e6f538db" => :mavericks
    sha256 "6a5a22f3d172182668008cb7dd1c78a1f618841e29caaa4d560a148675cb998f" => :mountain_lion
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

  test do
    shell_output("php -m").include?("http")
  end
end
