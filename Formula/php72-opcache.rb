require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 6

  bottle do
    cellar :any_skip_relocation
    sha256 "b25ae678e008b102fc4d3144b6a4fda6cdf239f9944b730f9e11f2bf15700c3c" => :sierra
    sha256 "52dbc0020fe6b01ffa402c9a41e00912fa35e902cd2767e60d0d5111b0b5ef4c" => :el_capitan
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
