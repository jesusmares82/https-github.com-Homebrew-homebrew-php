require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 11
    sha256 "02d27fcfc4a986c7550f47dcbb7bf3d4bdbb610599b3763c05a32e06320f5dd4" => :el_capitan
    sha256 "047d769bae06f4ead9a1982bb0f110eb7a075230385447bbc459bcc413665d46" => :yosemite
    sha256 "4bf4033edbcdc7306892510e5f698a266ccd5dd311acf254c02fac888060da0e" => :mavericks
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







