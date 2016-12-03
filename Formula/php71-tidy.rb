require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 6

  bottle do
    sha256 "214f15f0174f258319402f83036bd46497fb1f17009c71215a5cafbadcccca23" => :sierra
    sha256 "6b9fdab58ef32a9ecdd428e363b99242b63dc1e6c8c6c36c1a931331e4ec2652" => :el_capitan
    sha256 "c3d02ccb245d4d3c81941bc8577751faf848ab052da81bf0f049a2419d5f6fc8" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
