require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 9
    sha256 "eef72d9a8806056a1bfae8f20ff5de5567d1779f5fd70ff3c8c6db84a72e6b81" => :el_capitan
    sha256 "102b64c420b985889944bcef681991dc55effc428a3d0ace2f059987ba85c789" => :yosemite
    sha256 "805681724430951a62b0df74a622a6aa5457de12692c554f9a5633778076a96f" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

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

