require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 9
    sha256 "0582320a1560683fd2a353cc3d1f7ad3fad157200fe7ec49e4b1812fc011c30f" => :el_capitan
    sha256 "545fecd9f01f17f62a74f5d354b0b2bfc710c83537c23253425e839b81f11052" => :yosemite
    sha256 "c65cdd222a03541a63276e251a0408028aa4321941a11a72c3fba95b30ba3072" => :mavericks
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

