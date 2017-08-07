require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 14

  bottle do
    sha256 "e542828ab139c0aaffa183184ebce676531b7ac0167f084db72a1be720013542" => :sierra
    sha256 "61101bfc3d0d3343369b4e41896abd916b64ae43b9c6d3252e83c7c9174c61ac" => :el_capitan
    sha256 "7c6c57440e4cd3638b6a009164e77047cef8d9c48cd3f3f9338a7c1aec793920" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

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
