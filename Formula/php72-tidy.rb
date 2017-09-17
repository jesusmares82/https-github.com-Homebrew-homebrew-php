require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 4

  bottle do
    sha256 "d895c531e3067e83f50666ee455f72d1f8be209b53963c4604192e51c9bc2a1e" => :sierra
    sha256 "50e97c5e81e84258b082e74907cf51beebc5ee27f059b41daa9dd8eaafe19f19" => :el_capitan
    sha256 "6d076b30344ee74aa4a348ca714999bdbd655590bab41b77f7e7e809288614ba" => :yosemite
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
