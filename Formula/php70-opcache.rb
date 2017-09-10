require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 14

  bottle do
    cellar :any_skip_relocation
    sha256 "4d71524ccfca5a01fe5dc33a9a5df2f2c10ddc06054a44fe7d0fa98ba87bfef8" => :sierra
    sha256 "80dca5efeba1cac85358a0673aed7bbdc92c8b33ca4731f587492dd426a6977f" => :el_capitan
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
