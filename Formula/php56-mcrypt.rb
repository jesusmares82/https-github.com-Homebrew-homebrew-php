require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 8
    sha256 "f277d7ff6fc945d7be8858a2949d79ff1b8e0cbe1af212f6f0455a90d34ed485" => :el_capitan
    sha256 "051e4264ca42291f8b2e6c454f5b85d1202adb110a40dd755c0911f24d3fc327" => :yosemite
    sha256 "adc30a943980932f327afc6f99d0257bbf019939c07257a9667f2286ad98aebc" => :mavericks
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



