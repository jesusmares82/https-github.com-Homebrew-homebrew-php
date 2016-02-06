require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "1897577d956319f12c3884aad9cb0f98db616925556b5d668e77a3d390bc0aca" => :el_capitan
    sha256 "0f1dd1daf1203e5c4f52f8f7105c61afd79ce87e750e4a5d8e466f09bedf29dd" => :yosemite
    sha256 "31f724a290782eada4f3e93cce8fa9cfd50e7bf9e5f51b375b16f8668e745cfa" => :mavericks
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


