require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "ee4f68b52a12bc98f16d6a7f31c5cf787c40d185ef4b13e65c04977dfa1036bb" => :yosemite
    sha256 "7809ef54e364426994a86100f627ff49d2616c553369c0cc624ada43842dc0dd" => :mavericks
    sha256 "d8ab2321ad7321e38ca0f5122871dfa1df95562270c8f5c8d9c42a0574f5f7e5" => :mountain_lion
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula['mcrypt'].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
