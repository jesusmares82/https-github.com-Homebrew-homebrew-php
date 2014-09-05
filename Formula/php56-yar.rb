require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yar < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/yar'
  url 'http://pecl.php.net/get/yar-1.2.3.tgz'
  sha1 '7593e07b8d881cdce56764545f21f7d405297107'

  def install
    Dir.chdir "yar-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yar.so"
    write_config_file if build.with? "config-file"
  end
end
