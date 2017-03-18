require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 9

  bottle do
    sha256 "3a72093a2a77a3100ad5dd36695dab19a8ef4c6066ce208645285d4dc6b138d8" => :sierra
    sha256 "c3b884dd4d157b353f0303c161d03230a83fc4048f270ff2db4f4511375df147" => :el_capitan
    sha256 "f3ef1f1649f29a7c5cd376b329c77478c3ef2b39751a32a8ddc6c694ae858067" => :yosemite
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
