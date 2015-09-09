require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    revision 1
    sha256 "98a17cc625aa76af45d1c4255f3c745b544da2cd71913547af97657b4da32a3b" => :yosemite
    sha256 "b2154349bd6c9b87537c11faf13cd37500b1515f3deda096b479f7c2fe8a4f54" => :mavericks
    sha256 "ead2e2b4aa9e73405686c5e4e2959ea6aa33e06f3eb058f8a451ecf2a5d6b24a" => :mountain_lion
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

