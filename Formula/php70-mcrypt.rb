require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 7
    sha256 "90c7a62cf8677afc5ba0004f161f1b0b8f91c9a7d52b6caba96323eb2cbc20f5" => :el_capitan
    sha256 "2836165b78d84febf6400b440a1e662df9cf5b3a5090bc449f302c4f8458bd1f" => :yosemite
    sha256 "7f581f17d393dc448deaee8033f5d376001af51dad09a48c6dd46f02d1b6d4b6" => :mavericks
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
