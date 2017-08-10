require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  bottle do
    sha256 "c43a208a272a059e757f09de14dc1e94bdb655cea660cca11d7a4c29f09072f4" => :sierra
    sha256 "cbd757b143551b4bb6ddded1ab721eaf4f40e86148d9550b921ae544ffa480c5" => :el_capitan
    sha256 "79254ffc1561fce7124528321ca076481750ab6c40d69fc55c3d3e5f5bb2e3c2" => :yosemite
  end

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
