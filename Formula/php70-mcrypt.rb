require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 10

  bottle do
    sha256 "3012adf98947c2586b57bd4340b3b8e91a688d0edd08f8c3a78c117580f73be0" => :sierra
    sha256 "03fc1d49fb6b1776333a2ca3c33a4e04827ee2877de5115243c76c5a3bac6a6f" => :el_capitan
    sha256 "cf98cda99f4fe03543493ee9d037703fe2b6bc6dd7899594baff362893d93152" => :yosemite
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
