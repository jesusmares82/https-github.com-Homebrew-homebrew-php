require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 12

  bottle do
    sha256 "a48b11956d16535e1dec952381053b52faa7f8bea4ad3e75ad4cc009eaf27c0b" => :sierra
    sha256 "fd20443fdbdd79fe3a8a5ad01518931de30d58823a20d1448976a7c4e74a89b4" => :el_capitan
    sha256 "bec7b27899cfcc076034b99e8faf0990697f9e845b602d27481bffbad0c9050e" => :yosemite
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
