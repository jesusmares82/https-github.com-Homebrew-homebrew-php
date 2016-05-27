require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 14
    sha256 "4e34a05e0b9e5f3c2ac18bbaf0b6d772fb08a2c5233ade757b8a12a6442cb108" => :el_capitan
    sha256 "3b1f89f41f71cc66ce917f9c563c20e0af7c35779a7e63c9b228cfed07dccb47" => :yosemite
    sha256 "f61f4a84eaf5510eb8bab154077b970f153a3453ee0e837f09c50fba69ac216e" => :mavericks
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







