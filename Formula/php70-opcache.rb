require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 19

  bottle do
    cellar :any_skip_relocation
    sha256 "0d711e80e84e97f43e5ac62268da920e300548e3b3b8f1d64dad4ded392572eb" => :high_sierra
    sha256 "529d523bde788e2860fec634788c1285636ae6abab08de2727b6c7ae39d5c4df" => :sierra
    sha256 "86e6c95a05f5975f5c6c5f4bd2fbe2e8374ca9c1e48797da4a320946680415ad" => :el_capitan
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
