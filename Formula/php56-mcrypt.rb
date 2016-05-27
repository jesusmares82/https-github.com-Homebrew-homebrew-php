require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 10
    sha256 "1d4bbdd55840efb0a7f335df3f94a1c8e990f03f4c7e2faa9bbfcf1dacba9fb2" => :el_capitan
    sha256 "eb2893a71e68532ca3789d88fb72c97ffa33fd6775351cec35f36e331e41ff43" => :yosemite
    sha256 "03e3d217e01d7fb86cd97336d4578a94bcf2e844b781ce5e3160109f89ddd272" => :mavericks
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






