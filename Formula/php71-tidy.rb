require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 7

  bottle do
    sha256 "574dc4f98b903c4dc52c5572d67b1ba61aec9dcd6e7f6f6b12710512ef07bec4" => :sierra
    sha256 "4ff55707837465d0c986559467409dc28a01cd94c19e462275902103b9e4e4d2" => :el_capitan
    sha256 "3b987cb26c422ae27aa8dfc22e13893fff8cf6aaae76abb2b3bb15f0ec8755ec" => :yosemite
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
