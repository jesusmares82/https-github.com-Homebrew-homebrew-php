require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 14

  bottle do
    cellar :any_skip_relocation
    sha256 "af9d1b44750e459c27fe5a69dd46ab08b9ac0bc15c1e5d29f0e61d1df51c6779" => :sierra
    sha256 "e4f3d8119e821c161ac92ed72c1723eefdf9fec25e7ec867fc0983b37c5c95ef" => :el_capitan
    sha256 "9cc6b24c1d66488c81b6c02ce5fc0aaa5fca2328f5797d50be7a3a00829c9991" => :yosemite
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
