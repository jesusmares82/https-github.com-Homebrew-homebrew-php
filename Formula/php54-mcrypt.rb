require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mcrypt < AbstractPhp54Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "ad2bc36c848ed0650d2b1098357053e5faac1c471b2ff78ce2c7b7654d62581d" => :el_capitan
    sha256 "ed7160f374580a24f65a0b42407e8b296d37c11b28c829e6a0b6bdb73d0de84a" => :yosemite
    sha256 "2e5a9e27e36392babeb7d48a29c63091ea423ef379f6739a14d729319a8b0ba7" => :mavericks
  end

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
