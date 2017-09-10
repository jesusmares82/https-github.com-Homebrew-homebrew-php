require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 16

  bottle do
    sha256 "0613d35c873b37494834788825cc529991eaa511bce942bc0202abd40dc11567" => :sierra
    sha256 "57ffa8597e084ca011b3fd1220f82198029cd646892c643b0fb36709b26f8d3b" => :el_capitan
    sha256 "ababc3ef2ce3a0aad8b1150e922f44bb19afb5ea609f306a3993e745901effe8" => :yosemite
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
