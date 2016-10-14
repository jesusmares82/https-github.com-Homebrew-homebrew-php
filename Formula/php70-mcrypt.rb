require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "f1cec1c142ca591b278b6f95d064641f67fa2f3a69cf4b0efbc2ecebb5523cbd" => :sierra
    sha256 "84edebeb5db0c802ab29478d772dac2c75a46f92a2c9d3bb2b11a6cba3a9d8c9" => :el_capitan
    sha256 "6894b363ec25c253be5185d01733ba795ae0d070aff4bb30f535897acc08a9a6" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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
