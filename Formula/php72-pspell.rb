require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 6

  bottle do
    sha256 "1455c80193b089e68a9a5fe06ddd4d1e9a3a5864b7489b79b79cad3b3ad840ba" => :high_sierra
    sha256 "5caafa32904026a4e8696c58c5168b748e237005390a7a0f0b2e077446acbae8" => :sierra
    sha256 "780c80fc25031c4c38063b62b63139c1c44a5f648c431ae5a00e8125c4934db6" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula["aspell"].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end
