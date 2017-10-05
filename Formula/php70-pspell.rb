require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 15

  bottle do
    sha256 "48a0e24fa8f09a6f7ce7987d17c09a5679debafe7beac26f5f6e83d42bb643b8" => :high_sierra
    sha256 "2303db4cfc4929ccc88e7ff2a521451534aac385a3691a40689eaaae02a0703c" => :sierra
    sha256 "ffabd091c1040d1d15a21bff86cd1171dcb269582f04626584cab0c5a12eea2a" => :el_capitan
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
