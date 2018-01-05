require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 18

  bottle do
    sha256 "2247aec1bd4d58d21e5445182653178422753f2b6cb3a352741cdcde038b588f" => :high_sierra
    sha256 "ecac5b82d99fb6543e5a9622db2f9978a79cfe17a5b72805d7cd7597cfe50e1d" => :sierra
    sha256 "bc2da64c1e683464d89efb77b32e8829b21697e52aae17cc0124cf388f3ec5cc" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

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
