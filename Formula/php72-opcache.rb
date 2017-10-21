require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "658b557f3b4fdf912f2473000aa88f2a6677e427543e67f95af646a548e00be3" => :high_sierra
    sha256 "a319208af3837370a7e1fb2913d95c4caa127f2644378bedc322870708b06eb1" => :sierra
    sha256 "adc945c60a74e13de5b9ace45c85cfdf267d3fc927d1c6d26d68e456952641b5" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
