require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 11

  bottle do
    sha256 "23b3fb95345262f6266d487674020b529b8b574c71ee2b0b4c837fd89aafe42a" => :sierra
    sha256 "0db289396c6fee76e464fb8f4dc49e5e75b7dbe5eedd32ef2ef9eaae0547d7cb" => :el_capitan
    sha256 "32245d8d150a9bcbf4acfead459b6cb846fbd9ee674579c85be8ff0679d1998a" => :yosemite
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
