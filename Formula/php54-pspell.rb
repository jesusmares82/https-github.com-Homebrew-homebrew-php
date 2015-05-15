require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pspell < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "b57274f3d6d34a9ad46e19270cef269739572cc7640b2de08f11d6d6118f4054" => :yosemite
    sha256 "fcf636c13ea245f789d12676955791a1f23b13cfbd8fba62c41956bfbe7d51bc" => :mavericks
    sha256 "dac33e3af589dd90df82cd20fb9fd76b3a4a07c53abc8840b98aa153160ba3ac" => :mountain_lion
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
