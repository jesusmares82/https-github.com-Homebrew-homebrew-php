require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 14
    sha256 "29804f60813c3acd4eaeb79a7bb69916bd31a9b20a8996fe44d0c7eb8a87376a" => :el_capitan
    sha256 "dabb6e30b29913c7557d2e42f967f43028126b41c633b5253c24c054ee57adc8" => :yosemite
    sha256 "76c4095b61ecad3c5e1deb3a0050e20011dba488b1a75d8bc8eb64d8d64b6d0c" => :mavericks
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







