require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 15
    sha256 "a1fa07d4d93702f56d675ef0f165ae03c978758f5b05085bba01a0f7eb967835" => :el_capitan
    sha256 "71ed5f42b49e3a7f0719526c48a91d01c80aec999a66722075dbf9f1d33d4dad" => :yosemite
    sha256 "42bf5966316faf1f7002abf8aff401e69298953335b8af3cbf9bffc083d4e5b4" => :mavericks
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








