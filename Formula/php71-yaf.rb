require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Yaf < AbstractPhp71Extension
  init
  desc "PHP framework similar to zend framework built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://github.com/laruence/yaf/archive/yaf-3.0.4.tar.gz"
  sha256 "06fb857c75fcaba8c0a77d0150c5789f24970614ddaeafa69a6c62b82312152a"
  head "https://github.com/laruence/yaf.git"

  depends_on "pcre"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
