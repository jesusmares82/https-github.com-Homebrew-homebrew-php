require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 16

  bottle do
    sha256 "87892732130defffcbb762fc98db82c481c0e365a28cb43f64c6a24c14b547c2" => :high_sierra
    sha256 "08537e5823d247f0b519690e1f36990bd81d9b0a36dcf5125094d5212605dc27" => :sierra
    sha256 "4a1bcf5d760bdc6606cc65e7325d5ba3b1c4e96cb41e3dbc44be659b491e433a" => :el_capitan
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
