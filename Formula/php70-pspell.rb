require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 18

  bottle do
    sha256 "057368d6116eb8c4210ac78de3667ec6338da69e609fb70cb77fc61438587be0" => :high_sierra
    sha256 "bb6798f04496bb7f6761d5cdd701af3146b192a41942d44d4f462423665c5b25" => :sierra
    sha256 "617a4e458afa2bf8954f33e0f1679738be0c26eaef08b3e4e03667839cfc564f" => :el_capitan
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
