require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "263ddec163b085a1acd3bdabe04a5903f4a557c1db5e1fe6e77eddd691bb9142" => :el_capitan
    sha256 "3c6fb43554fb845839281957b9a39b837afaf20f95e9e9a6e259236732aa14f7" => :yosemite
    sha256 "4829fc7208673b1991a0809944576f65c7c71480a92b8eef9e0b81670ae9296c" => :mavericks
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





