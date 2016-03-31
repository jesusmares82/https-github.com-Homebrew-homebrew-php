require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "150f8606259c63aabe55975c82648fa4df6bd35a4117b6676dd5cc43033a1bb1" => :el_capitan
    sha256 "ef796e0022fe9130ce3664fa1a7a602f954286a0d1085fb485ac056a1a6fabd5" => :yosemite
    sha256 "4f3b43c8052d25eca44a8ef0dda7f3f2d8d3316d56fde045c332cc2d999a39de" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end





