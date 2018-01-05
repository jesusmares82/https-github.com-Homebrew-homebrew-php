require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 7

  bottle do
    sha256 "6dfde992141a421050caed0061db43f09368ff4023eb652b1528a7293fb11a00" => :high_sierra
    sha256 "f8f38f5a3a29051cc392d6fedc9ab7ecfde3269ca6b3c04663cfcddcfd3cdca2" => :sierra
    sha256 "14535dae303c1c23d1d09641835c086ddce56f2042e541b2017c952772f7d752" => :el_capitan
  end

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
