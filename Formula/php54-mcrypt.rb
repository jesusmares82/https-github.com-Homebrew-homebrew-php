require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mcrypt < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "31558d2c0f254bc08cfa39ebf1288f92b3821a908dd135253cf9ca770f32e1ab" => :yosemite
    sha256 "71abf1d21450d4a2298f454c5538e4fe4712645dd33be913f0b80ad75f1009da" => :mavericks
    sha256 "08cf49a8d272b2f0054ab82c92675ef5ed43e52700352d7a25ab5aca97208815" => :mountain_lion
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

