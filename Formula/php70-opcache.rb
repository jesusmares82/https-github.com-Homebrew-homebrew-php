require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 14

  bottle do
    cellar :any_skip_relocation
    sha256 "88c5ba897e5e08aa767e0eca64de1c7884f752fe41a7657d18c7e82751cb17e5" => :sierra
    sha256 "f1663aeb32a3b7b50181d82412aa8c94f69e405743ccdd02621d6ed7228523de" => :el_capitan
    sha256 "90e9be6e0ac348136fc6a16685842dd21b31c568214fe169bd39ff25381dea6c" => :yosemite
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
