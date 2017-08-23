require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 3

  bottle do
    sha256 "be173ef584132c7f42abfc1aaa72fd1726a3dfe825c27b32471858cb03ad3587" => :sierra
    sha256 "7f0b620b947d6a32a73488b6d77c76ebed81159bd59a246753cc002cbb155009" => :el_capitan
    sha256 "1b260b06020df4c87f4aa0eda050eb6690a908b1f9d486a4e5bf2bea7353078a" => :yosemite
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
