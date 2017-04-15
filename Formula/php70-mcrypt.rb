require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 10

  bottle do
    sha256 "e421ffd93d382d7c485d35ae4f44a774ee7e6bbde602e73ee106f1d2fc28a481" => :sierra
    sha256 "b9c0677ea15d86853074ce7036b68dc7824f160e126386920335749a62b68468" => :el_capitan
    sha256 "4d7fcdd373763c9680cf8b3a15ca58a6d2dbc94aa919c8c37209aec8b6e928ba" => :yosemite
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
