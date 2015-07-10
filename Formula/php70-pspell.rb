require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "e59823a2bc49db008172251fd7d0031d66b5c8082e6564e8a7609dd54129d93a" => :yosemite
    sha256 "a49be7bf7854cd9ed417e4f9b1d63cb3958b39e7de7396009bb33044652dd3d4" => :mavericks
    sha256 "5a12c9d347b9cb3f65f2a7957647a68756f3fd0f803c8d873db739f4ce401951" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pspell")
  end
end
