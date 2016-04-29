require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 9
    sha256 "349cbddfe8c9f6faf62642d8dd7e6922d06e7722098b62433d371f378f9d741e" => :el_capitan
    sha256 "d5ee266963b72d51f0deb8e8da33dc30af4fdc20e03c5e4904e7894cadea0451" => :yosemite
    sha256 "e76d1a52a1d1699ef9a8328cf515699a7b5ebb26d49e55cc97f0bffb136efb73" => :mavericks
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





