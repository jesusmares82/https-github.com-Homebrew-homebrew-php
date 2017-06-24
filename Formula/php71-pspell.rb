require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 13

  bottle do
    sha256 "0b6bdb26cd2673b487b9554a3d38196938b926239baaaa0159a08b94ceb55420" => :sierra
    sha256 "2a0d3164a84b2b5fc14963f30a35be91dda11854f78efa77741601ef23db989c" => :el_capitan
    sha256 "3ebb0e22e1fa976506c02348f792a3daa4fb12d197acadf8c6d931e4a3369c3a" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
