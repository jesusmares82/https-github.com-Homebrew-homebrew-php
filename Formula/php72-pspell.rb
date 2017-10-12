require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 5

  bottle do
    sha256 "19a7d121c33d585ced6406a922634437c3b954301e886eeecc5922cc3b4a89d5" => :high_sierra
    sha256 "286a7310ba261b1b290f3d58ad812fc010d4a0ad291221e883d1d9ca3fad7f06" => :sierra
    sha256 "7a57c09c888f396c0478b5dd0f72d3eb6f458c137a94e837e1a0d107512e98b9" => :el_capitan
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
