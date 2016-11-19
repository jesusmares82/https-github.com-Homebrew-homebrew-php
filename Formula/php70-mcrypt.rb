require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 5

  bottle do
    sha256 "f8ab3194c9ba3a23cc828a3f58f6322d58ca482691513a967330a5a1e5bb2ba7" => :sierra
    sha256 "07bdd8a31a8c9d59c8f91ae7d3832bd72ddb7888f2bebe01071f4bdfc333a2f2" => :el_capitan
    sha256 "009d404649b5fc7e97d8808d6ee8ece9c03e521c85682248c4f95b3f499b274a" => :yosemite
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
