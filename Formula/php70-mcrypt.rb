require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "7e54351b0ad7fc7d37d2c5db5fa77dbdf817140a0c644daeec1936e6d257febf" => :yosemite
    sha256 "6162218eaf3e2dd3588907a6889e2f36e6e002749f0b085ac1dc941f2c58a841" => :mavericks
    sha256 "e754e220a1c465037ea9d7200be643a678522486d6a4130fdfb62c4114eaccb7" => :mountain_lion
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

  test do
    shell_output("php -m").include?("mcrypt")
  end
end
