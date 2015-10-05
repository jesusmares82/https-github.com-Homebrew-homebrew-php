require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 3
    sha256 "6a6d99f39c11e9a00063e290c710d5f746299fe1ac532663852b15c10e3083ae" => :el_capitan
    sha256 "203e96ff70f92fd18ca014a14046bca9020c92cd52fdad600ab4b5ed25a01895" => :yosemite
    sha256 "4a030018d65e7e296f8963b0a09f04b467e9fb06096bd501d3c3263f0d04af33" => :mavericks
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
