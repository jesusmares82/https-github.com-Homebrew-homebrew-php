require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 9

  bottle do
    cellar :any_skip_relocation
    sha256 "50316dc3bd9b5fe549ab16d9794cf4ca1f29060806f8c45fa261ebb4fade5985" => :high_sierra
    sha256 "d9c674bccec3fcc7326f9e3f99b571f8edaf820756aa3e4416d695751ad47e67" => :sierra
    sha256 "20c03d3188e3c5498dc76dc4d08374100a96b36468582f0156cd2983d6d736ae" => :el_capitan
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
