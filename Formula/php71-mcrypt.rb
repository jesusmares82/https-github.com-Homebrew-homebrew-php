require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 8

  bottle do
    sha256 "44857a80211e6be177a931d09c22b1432bee3120bafa9e554cebe3c8a08a1ac1" => :sierra
    sha256 "f249e08c095d59f432800f7f51562e6fc67ce3a203b7ab08bc9f2012eab55f25" => :el_capitan
    sha256 "abc5b87c435af677d1856d567e1450da9b12d0139647f8f4a420c8a15b5493ed" => :yosemite
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
