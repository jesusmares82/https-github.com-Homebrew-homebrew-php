require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 15

  bottle do
    cellar :any_skip_relocation
    sha256 "113190c643b8959dd04802d597d5a2bb0a3a02559dec05e29d28e1153a769405" => :high_sierra
    sha256 "417b3ddebb0518eb44b2f22addcae669be5359eb701070cdfd990fb85e08dd64" => :sierra
    sha256 "29c2fbe581132f22f6457e36590ad1ab23a239c7e0121f822cf8b569714642d7" => :el_capitan
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
