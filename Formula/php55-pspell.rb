require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "389ba025936bfc073d4486cae8fbdc6e24d1b7fd9c0a68bebe2ace966c6bdf00" => :yosemite
    sha256 "9394a42ec78eeacc75fbb26924de765dc8a6bba8b5ebc771ea7cda791fba3159" => :mavericks
    sha256 "f53114ce40a2b8d5a075aed77e3ab10c2a95e9632a63c415afcb6e50415c7237" => :mountain_lion
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
