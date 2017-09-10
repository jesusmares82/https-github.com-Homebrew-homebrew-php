require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Opcache < AbstractPhp55Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    rebuild 11
    sha256 "178f86a5475564cfc4843b13199d9941bb92cd9d67468ee53f005b92be829dee" => :el_capitan
    sha256 "41e3434b937490e5846f2c4423014f781dde500c332f83e95fed07b0e6ac2f39" => :yosemite
    sha256 "6d2f00637f4dfe3bf3f84648b007af6a870466505e53062f9707287b0fbe978f" => :mavericks
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
