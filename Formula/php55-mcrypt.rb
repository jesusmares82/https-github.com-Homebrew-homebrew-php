require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 10
    sha256 "99688eb86730d2d1701cbe1490cdc78ad82756fe8231dc8e735056c570fad2d7" => :el_capitan
    sha256 "8d065582698725fbe1fa1127be9c0958c2ca3048d9162af04338c249125b098b" => :yosemite
    sha256 "95b5e0fc04ac315cfda939c2263596c9014ca8b9e509c10df80ff4ed667c604a" => :mavericks
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
