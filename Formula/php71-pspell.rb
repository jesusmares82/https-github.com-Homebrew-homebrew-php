require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "4a8b09b6d98aa8887b6dba74fa8491d1737743f23b30e412b3e941b36a96a98a" => :el_capitan
    sha256 "422cf2bad48309714b54e2c89ae9753fa50e5ad70335a8d48dab36c4bd11cc22" => :yosemite
    sha256 "acd56acf4bfea8a77be996f054f52b17788c91c12abd4888d141631b816cf7ec" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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
