require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 6

  bottle do
    sha256 "6e88d5ae671bfd3241556ad114978131bd5af7ae846962b355bd9284d0676b71" => :sierra
    sha256 "826848961625d6ea9b3224f44ae97d976836d2765da5a0eeeced1c7b5c3c06d5" => :el_capitan
    sha256 "cef8dca7b68c999501388b9a27399ba9a79bc02b5260916c690c8549b9d4676e" => :yosemite
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
