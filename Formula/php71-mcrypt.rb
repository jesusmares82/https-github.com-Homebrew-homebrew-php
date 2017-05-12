require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 12

  bottle do
    sha256 "6e4f01d3f4d1a43703f594a850ddd809e14058aa43ddf90f4cbaaca20212f151" => :sierra
    sha256 "e233b1434c7a85ce442aa8528a8d04e7ab45578cff06502b1a27bdbd2a6f72ff" => :el_capitan
    sha256 "1c2b3a442f4c8c44030b2028cdd7d82c29c1f377d0f63c59e6dfd88ab4ba7607" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
