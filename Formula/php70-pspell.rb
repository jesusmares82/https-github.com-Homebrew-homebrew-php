require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "ea91a26a0f9bfd345f32bff4f7c23f2f5dd671f150df83b8afc3de5f34597cb5" => :el_capitan
    sha256 "eabe53ad903c41189720c570eaa6dd6d805b7d9d6f5b2acebd3d6846e1cc411a" => :yosemite
    sha256 "f46ea275e7c8aae49a326c3fee7a55569819220425d10c2ed1bfcb33543dbc6d" => :mavericks
  end

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
