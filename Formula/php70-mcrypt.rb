require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 13

  bottle do
    sha256 "9e7f3906f1ae6bfd500c105c477a809379d91e892112c4955261f58ff99f2777" => :sierra
    sha256 "93cb057cbb6b4707ad1075d1780e2e3f1b3391045e7b2cf9061f8759eb6f5f77" => :el_capitan
    sha256 "0f5cadb8d31b38a8a48301e07b9591a1ae7dc6c0f0fdb01fb0584331b2329a46" => :yosemite
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
