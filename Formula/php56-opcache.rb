require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  bottle do
    cellar :any_skip_relocation
    sha256 "14a9e97ca0331039a1a8a2c946a18337ced32f66707d228b468fe5590c16ae26" => :sierra
    sha256 "4ad3f39a6e6c4fef51afff8f0501d64a27ae17f0d5dd994ffc75a044bfcdc513" => :el_capitan
    sha256 "8b0d70fdd07286d25fcd3645eda8bfa44a3c4d6aa2f06c77bf2c4722a13279b9" => :yosemite
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
