require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 12

  bottle do
    sha256 "d59a2eeef5fd6e0f329402810f7f32ab993f09177b0fee74be6c1e4d9394ea51" => :sierra
    sha256 "ec2de98454d833e062ae86ac5d40000ba6555dc8ad2906155b8dde7a7fd33a5e" => :el_capitan
    sha256 "971c6ed737c451a561a0133ab5bf180e58f653047caa7083e7782dc289427030" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
