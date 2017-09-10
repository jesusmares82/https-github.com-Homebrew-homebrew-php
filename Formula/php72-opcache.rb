require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 5

  bottle do
    cellar :any_skip_relocation
    sha256 "38131e07f317b904d66749f8a9e95e7fe74e9967f3b3acbc04ee46180e2da9cf" => :sierra
    sha256 "da29ca46b2267ab3fefdf7008a980f65b639b0e9b5377c937730715b486f6976" => :el_capitan
    sha256 "3236e343936930d1fb6c6d1a8109835fd88d1be18196c547927fa8e808e828ae" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
