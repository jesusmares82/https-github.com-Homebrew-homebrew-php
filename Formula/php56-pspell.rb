require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "82964d46bf9e8d62832396f0f0c0808813f15e15fd719d724095a7252630718f" => :yosemite
    sha256 "6821f5c9e985ecf0022af2407207e010fbf498774ad8eb21411d9f0eb3d2e63d" => :mavericks
    sha256 "faf278ec2220936b0db7c3eb1fcda9ed346736d6346b4d2acddcfb21834de75b" => :mountain_lion
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

