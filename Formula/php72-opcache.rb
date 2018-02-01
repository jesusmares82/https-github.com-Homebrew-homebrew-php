require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 12

  bottle do
    cellar :any_skip_relocation
    sha256 "210c89ddd6ec6bca647196af3ce191acf1b090e6cb155de849be5b916f3911f5" => :high_sierra
    sha256 "7abfd398cd4263cedc11b0dd3635ca99f08f97c6368425f28fb97ec43e24b9b3" => :sierra
    sha256 "8e3f53e499b90801a1f2592a51ed4f9dee8e17e76636be3ecfb1d33445b60fe4" => :el_capitan
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
