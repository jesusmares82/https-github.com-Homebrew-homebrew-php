require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 18

  bottle do
    sha256 "48bc9402b64c61abef231ec09972a0f9547cb9fea065f8a0d0f3c36b3f0eeec4" => :high_sierra
    sha256 "b2ca121b3e298e899779d6e673e3fc451771a83c5a922591b0016c79725ad046" => :sierra
    sha256 "fba0ecb2914e4699211e8a966e0676bdcc9ddc3f7e1c1e86a233e6aed4f3f18f" => :el_capitan
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
