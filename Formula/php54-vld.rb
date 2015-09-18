require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Vld < AbstractPhp54Extension
  init
  homepage 'https://pecl.php.net/package/vld'
  url 'https://pecl.php.net/get/vld-0.13.0.tgz'
  sha1 '19936e64c29339d1a5cf48fc18ef762fbd8a8a1a'
  head 'https://github.com/derickr/vld.git'

  def install
    Dir.chdir "vld-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/vld.so"
    write_config_file if build.with? "config-file"
  end
end
