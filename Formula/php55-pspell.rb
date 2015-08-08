require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "ba41d684031039896164863db8a3a1257c34ba11d39a1e2bf3a9b8401195b026" => :yosemite
    sha256 "2cd5beb7041007af6c889e978e6119a8c02f45079af1e0de49e14781e7c60a5d" => :mavericks
    sha256 "a9b9507dcd11b02504eb5e9fba124ca8d41d109161b10dcc7d309c48dac41f9e" => :mountain_lion
  end

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula['aspell'].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end

