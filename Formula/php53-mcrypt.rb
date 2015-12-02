require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mcrypt < AbstractPhp53Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "f9e5929632284e8e9111468c00420cce5dde3d087a06b436ac8fe399c00aca36" => :el_capitan
    sha256 "0deb354896fc635a90f8291e6d8e975bfa25a2a5d67d74ba0e858d96067cacb4" => :yosemite
    sha256 "a4d9eb7f48f167a388754f2cd38d18b497051017c098c85bfebdd7ac8ce53797" => :mavericks
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
