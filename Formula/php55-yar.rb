require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yar < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/yar"
  url "https://pecl.php.net/get/yar-1.2.3.tgz"
  sha256 "8f39e6174476e2eae6021f83b69bcf77ee22949654a43c9985dde1a3c7bcf66e"

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
