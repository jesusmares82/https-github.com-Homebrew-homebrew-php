require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 5
    sha256 "b27c5472717dc7c6dc028b4d2f49901706a854f2f043390ca2903fbd156c015c" => :el_capitan
    sha256 "aa12e84b7e21578a52513d8c769399d3285c4ab6c6ff0b7dfabce4c5674505a3" => :yosemite
    sha256 "5578762609b80a928f0840339afb79d260c8cee56577d821cf0240c71d7cf985" => :mavericks
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
