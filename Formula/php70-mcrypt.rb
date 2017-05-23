require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 11

  bottle do
    rebuild 1
    sha256 "f66db1299ffefa28f8a06fc83106ef810ac5f68422092b08ee6b6cbf5f584594" => :sierra
    sha256 "6bdf54c6b0430ee09bcd26e62e1147600b53d83e8b09ca26c816a8281de26ca2" => :el_capitan
    sha256 "c13dcc375e261738caef359279989d52d5b5f0f4a3b52fe109a326e42e2c71c9" => :yosemite
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
