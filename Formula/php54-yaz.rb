require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaz < AbstractPhp54Extension
  init
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.6.tgz"
  sha256 "dd9b919ba3b2a09a9c77c847407f106512fe75979cc0689ebccef08c80719eee"

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file if build.with? "config-file"
  end
end
