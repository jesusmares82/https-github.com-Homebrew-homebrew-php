require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 8
    sha256 "d64836c23866936017bcfbce2dcf3251064d1f6420efb02e52394f4041578c20" => :el_capitan
    sha256 "44137e7e9654bef6e3d22fba86884442b4ff65d2c667b5f8255a95aeebcc8c40" => :yosemite
    sha256 "aebe09aa5fc1fbd11ee7db0886bf161dc74b7a63871bc7dc02175f30373e5415" => :mavericks
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
