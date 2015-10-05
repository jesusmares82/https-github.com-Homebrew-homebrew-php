require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 3
    sha256 "1fad844f6e4a6348e69845756e0d6145e59632d6d18d051c46d81b742656fb13" => :el_capitan
    sha256 "2b6fd1dd04a17cc7b448fc544e8255b5130ff71c7008e1bc14d1dafb757bc84f" => :yosemite
    sha256 "69e3f190cce973b4c410ff6e683e23fe36e4cb23287ba5a5b0dbf9bc9713349d" => :mavericks
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
