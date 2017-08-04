require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 14

  bottle do
    sha256 "2e375ce664434376d35ce68122ed9ad837a2c7183f70fba1318f1190bdaf4af8" => :sierra
    sha256 "c91fccb67a931fc22cb08f3c51e984ea58a14603db397791d2ffec6d2e2159f6" => :el_capitan
    sha256 "7acfdb52516c396c8f81733fbd2034450ec9cf039bc31b551c4f5f9bc1710f69" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
