require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 11

  bottle do
    sha256 "9ed9df6bbef6cb5c52fe7359da5912d8868199597be5a52e99be829c46b9f127" => :sierra
    sha256 "498c6c40bff28016f99fe746bad7de3f37f548e2dd6eb9821ae96bbd8cd65d18" => :el_capitan
    sha256 "1c4a9bca3e7f0f4a940754a2a922f504f6d516579e4686e5d389a5a62b5015d8" => :yosemite
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
