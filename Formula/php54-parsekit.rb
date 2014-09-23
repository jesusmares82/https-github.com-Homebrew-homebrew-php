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
    url "https://gist.githubusercontent.com/lucasmichot/76018aa35589ee90a483/raw/d967ae3aac6d254046cfa545894949dff39ada79/parsekit"
    sha1 "4493fd29ff29dacd994fa5c1ec49ab50175902a5"
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
