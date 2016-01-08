require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 4
    sha256 "d5a693d149fcf2b870f362e2d20af1d8e2aaef51d6c11b0a38dc986f874f6817" => :el_capitan
    sha256 "30c35726ff701ec3e3f32ea073c0dc656ae244079a951697d06e3da212378bbb" => :yosemite
    sha256 "6024952564f19fd82ea5bc2d2c10e240897536f4599aac060f924d50e8fb3b74" => :mavericks
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

