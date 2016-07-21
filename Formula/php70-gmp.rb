require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 16
    sha256 "d7479764b9428cee0e081a5659e841387b46b8c3cc3de21c32bfac1d5cd0dc50" => :el_capitan
    sha256 "ae322aa107f08c4814582be373f69a648e569297aa834b7f9dbf398d8883e452" => :yosemite
    sha256 "a046dd6b49a86331b896c549afad99d1172884c1b445135c6e77bd9b3a9c35a9" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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









