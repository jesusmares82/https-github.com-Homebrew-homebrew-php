require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 12
    sha256 "05b55eb5041fa2e103a501dcfe1353742a31d39c27a26feddb93e4e2486fc5fb" => :el_capitan
    sha256 "0ae63385b0a8530d6fc1f88128d87e529aade8b372cc4c56bb5167b452eb281b" => :yosemite
    sha256 "8e2215b96300c0b2ef6f6b33e4b0334dede44d618f2f7d7917d09ecbc9cd959b" => :mavericks
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




