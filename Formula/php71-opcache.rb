require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 16

  bottle do
    cellar :any_skip_relocation
    sha256 "44d72b04db50830d527b594970363ad1c355e8de5bf8f41d4d88b89521b5d726" => :high_sierra
    sha256 "8d78e08bd2c25a3238a1382cbd46e1a0ff7d3a002d09c59ced2ed0b03f7674f1" => :sierra
    sha256 "1b37d3bacf80e3dcb4bda87680e658e09fe91371c139ea73e41a43bfc862da2f" => :el_capitan
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
