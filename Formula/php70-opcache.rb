require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 16

  bottle do
    cellar :any_skip_relocation
    sha256 "f39e1e79c973f7a393990de183fbc938e1885586db4899c7b450b25e1aa86184" => :high_sierra
    sha256 "c52172fe5dde8d3a56418e442bb8f398e0ead430734a0ce5652b0b41754b2929" => :sierra
    sha256 "275239c35dfff371a97c93225636d9d15118a88fbe7e6b90269938ff95c2e057" => :el_capitan
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
