require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 18

  bottle do
    sha256 "cd27709bfcc84a3dab4fd6293c61a164127e08ba41c28b45f6fc40934f891459" => :high_sierra
    sha256 "827f5609501b4557caa428d424362a4e2f51663f4e1395234fe02fcdd70e916f" => :sierra
    sha256 "01c3e420b9ea1ff1f42e2633b68d125d0ff7bf07cd7fc986027e60e502faf666" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
