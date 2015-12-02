require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mcrypt < AbstractPhp54Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "dcd85a6fe280457019fe303201865bf1df155e7dbc5bf6310f60fa91f3bbb163" => :yosemite
    sha256 "8e0d7c87a502399483bf00f3e3f009c7beb624ecc17dfcf3e7003adc4c033f25" => :mavericks
    sha256 "40c807532946df0da650d9e4d6e34af48abd573047350b0f522d6fa31c2603b6" => :mountain_lion
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
