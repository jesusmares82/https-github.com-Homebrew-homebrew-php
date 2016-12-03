require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 7

  bottle do
    sha256 "ed2bf878e2a6edee91a9296af95ea38ad85ec5d7de1c7e7828671de6dd52b165" => :sierra
    sha256 "28f26fc3b38a0c7132fabb55ec764e864817f599a92984d079debb1d9bdc5d99" => :el_capitan
    sha256 "cfe458e4bfc3b18a5e249d60ed9a237e43a0146b77864b8ecb1110b3cc0ea36b" => :yosemite
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
