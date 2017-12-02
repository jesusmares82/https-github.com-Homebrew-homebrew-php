require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 10

  bottle do
    cellar :any_skip_relocation
    sha256 "5ad5d9bb8be0c8e70bac0c74d17a0498c517b1d1c7a86e2de01f3031432715b2" => :high_sierra
    sha256 "46c1ff1c6d0aedb2aaf859070ddad77b5d77caf557f4c4649db2292d8e363b49" => :sierra
    sha256 "c464b8adbc3d4ab4872955e9843a3d846dea53b0506b4f813a77cf8f2e1281fa" => :el_capitan
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
