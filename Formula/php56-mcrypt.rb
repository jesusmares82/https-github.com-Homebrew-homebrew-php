require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    rebuild 1
    sha256 "55771444b12e14671bc63ab1acef4726175f2ee39b133250e093e2bfea327c4c" => :sierra
    sha256 "8ba8f64d4043c73d926892ee90bd44b008664e939743eb29bd0508a4fdcc9e04" => :el_capitan
    sha256 "f8eb892f0b5c2236320ebae890549869e397fddd76648d5d835472021b6aa56c" => :yosemite
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
