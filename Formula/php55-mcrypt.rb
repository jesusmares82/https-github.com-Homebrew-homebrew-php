require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "bd8edb6686653cf75dc5e20812a2a62c718ae09bf8a6b6c4f5d6ff54bff540d6" => :el_capitan
    sha256 "7ce5ca9a6be4d4fecf611fbc1fc4ca57dc32ed4f9083a9b90a00f53e2e3d255d" => :yosemite
    sha256 "9447f0a145add8bb0fb794430b95e1ce56bce1e1d1e4125818a673a1bcba8091" => :mavericks
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end


