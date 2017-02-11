require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "c3efe44c21d9e608fb43473d805a0e40619f2265b148b9a4ee99e7279205810c" => :sierra
    sha256 "cd0d9b999bc11ffef147151f54e18b29ed37b37c1740a9cd0267dfab61a7469c" => :el_capitan
    sha256 "9405dc2ab853a663a611103afbe305d271d60dec526e3d8cd738f24987f091b2" => :yosemite
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
