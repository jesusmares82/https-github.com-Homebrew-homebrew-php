require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 15
    sha256 "486a1cb17e759c1d0e8ea9dc04d0a10a296f1b1b29e7995ff23a81ebc3b63422" => :el_capitan
    sha256 "ec407b945cdddfd4caca57c5521811552ed0fea545600f350c5ee5d486c81f7d" => :yosemite
    sha256 "00140330a69f24fd1629d4bdfc823dacd1f3ab1e4a2597a88e6a49f9ae8f2e1a" => :mavericks
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








