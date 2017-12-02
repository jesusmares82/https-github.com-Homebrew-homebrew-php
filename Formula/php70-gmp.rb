require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 17

  bottle do
    sha256 "d0833ad60a31f346bf3861cd4174919d9e0f1894b6c4ed0f414f0e3b6d064e87" => :high_sierra
    sha256 "78e1376ff84bcfbd6316c9f466fba197a3b5af7757b066fbbf5915da05fdcdda" => :sierra
    sha256 "17e37eb200a530c1fc9d76d69a62ad398a337ab8e818073a53a21aa6bf27b0a5" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

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
