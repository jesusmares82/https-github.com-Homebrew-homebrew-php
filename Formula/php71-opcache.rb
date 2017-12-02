require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 17

  bottle do
    cellar :any_skip_relocation
    sha256 "dc7c141d0f58dfb3599e9e85f79e3834c1d1f0060a4503d7d94fc9a8e6b3c0e1" => :high_sierra
    sha256 "1097b3e13f9623c0b750f637a81a1bfd43caff4b7f4e4b24bf48ff18011673a5" => :sierra
    sha256 "85f880e693cfef7eca719de5c5a2f7033d5cbef72cfda0527763f7bee7c773df" => :el_capitan
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
