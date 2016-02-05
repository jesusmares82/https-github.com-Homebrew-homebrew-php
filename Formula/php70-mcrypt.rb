require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 11
    sha256 "daefae6e84e80efcaae3045d6c1b847687295cb2fa3b4d12172a4934e564b040" => :el_capitan
    sha256 "27db08478354b21cc43d80b2fa726d58b9832dda1deeeee0871f18e994ab025e" => :yosemite
    sha256 "68b7a297faf66fc957b7056daf2047eb3c91fcf0266395eee9b2b48af6377590" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

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



