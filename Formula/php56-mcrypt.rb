require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "357a9a5411d5971700b79ac5cae0a1ce721fb05ff35427c237589a4537de0fcb" => :yosemite
    sha256 "f7901c18da2abd82a8fee2231dee94ddcb569427b9634b79f1d02fbbb4a492ab" => :mavericks
    sha256 "261964997ba8186563d178234b15c4117fa317c542ab4477f2a0cd9689fe9e90" => :mountain_lion
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

