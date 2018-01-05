require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "547a745db6f8f4e6351ebecae83f52ba5cc4b390daf9e30781ef4c786983a6e3" => :high_sierra
    sha256 "302a7eddfa6f1b4321430b4546d1bdb9e4edb9c2572b97281340b5706556e558" => :sierra
    sha256 "f36c7cae1342364de7cf2f829001c848882e59736a90289a855f31e56fed1679" => :el_capitan
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
