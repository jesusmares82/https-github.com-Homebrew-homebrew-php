require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 8

  bottle do
    sha256 "6bd7cb4f1bb743f0abe91bfed2f05f42dc83a507ced1a32dca923e9f3146c212" => :sierra
    sha256 "e5fb9dfaaae47748cce3bd58c91e4815c87709d308e55905afc73c5bc7a70616" => :el_capitan
    sha256 "ee5798507fc161bdaca0e4f5eb12dd13d78d651151442ce026821876265d97b1" => :yosemite
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
