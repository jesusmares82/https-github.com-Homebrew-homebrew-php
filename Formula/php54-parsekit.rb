require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Parsekit < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/parsekit'
  url 'http://pecl.php.net/get/parsekit-1.3.0.tgz'
  sha1 '89d54548390e3136e7ea38914f716454c4f7a113'
  head 'https://github.com/php/pecl-php-parsekit.git'

  patch do
    # Fix incompatibility issues with parsekit 1.3.0
    # and php 5.4 (https://bugs.php.net/61187)
    url "https://gist.githubusercontent.com/SteelPangolin/5252ea888d09c51b7d35/raw/298c52816c6d8794aecf14416db20c29fadbde0d/parsekit"
    sha1 "385183756097af5e548f6115844bd54b5ae00946"
  end

  def install
    Dir.chdir "parsekit-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/parsekit.so"
    write_config_file if build.with? "config-file"
  end
end
