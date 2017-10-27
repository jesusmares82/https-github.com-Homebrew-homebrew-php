require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 17

  bottle do
    sha256 "fa8ebd34a00d42e2a032b35cbc11993f57eec566f9f7f2e50765d35a2ec4683e" => :high_sierra
    sha256 "6fee7e0fefa5f717a847d6d76cd1877248e90f813265d7cdfeaa99690f7b417f" => :sierra
    sha256 "8f81b369672391fef2ffccf5f1aab74b693b7d6a56f17f2a2bbdcd263b370278" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
