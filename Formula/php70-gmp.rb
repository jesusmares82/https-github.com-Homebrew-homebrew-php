require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "6ea8eaa18e637809022d31fd186e0e9f8c2db7ecb3494d69b84966c3d8cc3ca7" => :el_capitan
    sha256 "37bfe2629dc05d36ac65c35449b84e642f9e6c07fa8dacd2f4598a04bb477e91" => :yosemite
    sha256 "59460c5ab4942b7a40d09d6cec7cf81a0014786c52d91f205b8a0b71d270a85b" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
