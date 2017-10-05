require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 16

  bottle do
    sha256 "7c6ebf4b7aad8d6afa49847ec05b1ea8b3b58815b85fac3dcbef38e1c4d6ab3c" => :high_sierra
    sha256 "052fa5b31c082b03817aee88ae8130cc3b4c78f19deee0f31651eacc374d298e" => :sierra
    sha256 "b2fb589d1611d972dc0e6e70fd90c67ebaafdc64f9c8963dde2a679a78cd6ef5" => :el_capitan
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
