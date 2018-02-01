require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 12

  bottle do
    cellar :any_skip_relocation
    sha256 "6d8af8384e94d28458c4846aebbfe5800f07398faf2abc0f4179b5f59800a6fa" => :high_sierra
    sha256 "347bcf956f5247be4518325f35be3e9272c945eff5c102e6f2383df9ca8aa74f" => :sierra
    sha256 "58b7a1e91f87c832ff5bd2ee073819f1d0cb50a01a5dd8d9915a9e3da9538041" => :el_capitan
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
