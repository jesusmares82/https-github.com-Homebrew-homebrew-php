require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "76a6b14b076a1aaea39a381fab1ffe250d9c834101adfdc9e756d84e9b3bb153" => :yosemite
    sha256 "53c88f34ac452210da3618239bd57ec14f2668e2d31abdf1d9836a50cbe4a0ea" => :mavericks
    sha256 "70b8fe4d09087fc5efa807b954d5815f5605fd07393b68103a605c8bce11b21a" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pspell")
  end
end

