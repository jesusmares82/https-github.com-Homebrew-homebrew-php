require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Judy < AbstractPhp56Extension
  init
  homepage 'https://github.com/orieg/php-judy'
  url 'https://pecl.php.net/get/Judy-1.0.2.tgz'
  sha256 '6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118'
  head 'https://github.com/orieg/php-judy.git'

  depends_on "judy"

  def install
    Dir.chdir "judy-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/judy.so"
    write_config_file if build.with? "config-file"
  end
end
