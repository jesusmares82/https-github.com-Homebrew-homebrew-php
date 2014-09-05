require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Http < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/pecl_http'
  url 'http://pecl.php.net/get/pecl_http-2.0.7.tgz'
  sha1 '477e6ac84d16fb813c4bbb324c1763a899e11999'
  head 'https://git.php.net/repository/pecl/http/pecl_http.git'

  depends_on 'curl' => :build
  depends_on 'libevent' => :build
  depends_on 'php56-raphf'
  depends_on 'php56-propro'

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename; "zzz_ext-" + extension + ".ini"; end

  def install
    Dir.chdir "pecl_http-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    system "mkdir -p ext/raphf"
    cp "#{Formula['php56-raphf'].opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    system "mkdir -p ext/propro"
    cp "#{Formula['php56-propro'].opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent-dir=#{Formula['libevent'].opt_prefix}",
                          "--with-curl-dir=#{Formula['curl'].opt_prefix}"
    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"

    # remove old configuration file
    old_config_filepath = config_scandir_path / "ext-http.ini"
    if File.exist?(old_config_filepath)
      system "unlink " + old_config_filepath
    end
  end
end
