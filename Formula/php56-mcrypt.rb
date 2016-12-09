require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "2e65cba0f6f87820f7f025a140f29853f526d2021782d6e26d829a51c068c43b" => :sierra
    sha256 "f4fe1cfb54fd4e78d94824cce1ddc491da36cf48d6517f8273701eee213b15e1" => :el_capitan
    sha256 "3cb86460332e522034894ad99c536e6f627e53123d64b3ef4fbaeeb733c82ce6" => :yosemite
  end

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
