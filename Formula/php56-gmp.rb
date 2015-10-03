require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "5c87cff68d5240dc49b8fc8b3f61866618fccda248c4479adaf7806c1f530a9e" => :el_capitan
    sha256 "dce7ca73db9bf13f10d74578a85c0321c212e6d1e512a758199c4044b8b7784c" => :yosemite
    sha256 "057290ab44e6a8d2e17f919580dd23f5ca69fecc045a9b68774c058a0b3c74d3" => :mavericks
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
