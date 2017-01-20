require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 8

  bottle do
    sha256 "143c1feeaa09ff2203a0957b38a517e36afea04aeafbb770af450ae4fc15090c" => :sierra
    sha256 "ed994921386d2499f4fc37e824f5543df02140dd8835bab5303a0d0b6370f6b2" => :el_capitan
    sha256 "f5dd10d77c35a9a57ff61fdd29b21bc88f019917af6c6cdc5d1b404801737ded" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

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
