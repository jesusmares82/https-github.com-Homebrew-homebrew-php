require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 17

  bottle do
    cellar :any_skip_relocation
    sha256 "f8b1b75b09e7555c2ea3899766d0c912d9b627e315fe12396ac1804f1dac72f0" => :high_sierra
    sha256 "627af0e1a0c274c09b5a6f37d6f0b6bc46198d35cf1e5e7df7ea63ff765c2808" => :sierra
    sha256 "9bbd819d2b6450bbc118359bd11c39aa63c993bdd9c2428574ed642e5a3bccc1" => :el_capitan
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
