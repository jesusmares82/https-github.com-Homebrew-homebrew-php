require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 15

  bottle do
    cellar :any_skip_relocation
    sha256 "1409c1bef5fffc7a671d44ab80ceac3fa2ef58b15b12b08f70acdc5671efb65d" => :high_sierra
    sha256 "e8dbd61e548ae4ab434f5b0e18a278b605c497dc62944db895c68fc0082a70b7" => :sierra
    sha256 "e2f36e401e09d7809a76f8614310981c430d728fd99cbd87dc485474bd8a4eed" => :el_capitan
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
