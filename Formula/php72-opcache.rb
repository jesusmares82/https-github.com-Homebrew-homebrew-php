require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 9

  bottle do
    cellar :any_skip_relocation
    sha256 "c27deaa82f367184e8eb58803e56de6648788b01ea2f3e812d5ddb0522e24ea6" => :high_sierra
    sha256 "14ae63e0fedd004853b8aa890db64caaf363fcd7dfd40ce1746cac2deacf55f3" => :sierra
    sha256 "f57bc7f78fdaafd7ce27e4c61058611fdf29001b634f39153a995a57195e4788" => :el_capitan
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
