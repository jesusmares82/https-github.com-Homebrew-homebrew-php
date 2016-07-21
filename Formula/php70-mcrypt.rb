require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 16
    sha256 "11f2b66fd65e8b6476eaa64f2486e5aea91297316404f4786552feb466daae90" => :el_capitan
    sha256 "b909b601bb2ead8359363ccb24269fbad58fc83175e895a15174dab6ece51f69" => :yosemite
    sha256 "3671a972c5c901c8016ff3fb2d955c0bbc4b0e34dab981f23705e0bdca0081b1" => :mavericks
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









