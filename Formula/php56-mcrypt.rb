require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    rebuild 13
    sha256 "4a96851b66b22c81beeae9bfa3a79d6e431e3949e153b39f954b66f379f8c361" => :el_capitan
    sha256 "506d35bb65bd4610c99841b34f13c788f34076de1d8eb7354e2f0adc9db25453" => :yosemite
    sha256 "76df11ceb1f22242bab6acb3e0a00d122ef225ae38298ed99a1ad9209de7f766" => :mavericks
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









