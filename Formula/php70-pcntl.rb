require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "6ada3164515b45803c6b8e3eeafbb614c1f53eed8a3a31625d973a046039d959" => :sierra
    sha256 "649f3f6976b2c794208e501a247322e9da93afacdaedef5dcb11027246f45096" => :el_capitan
    sha256 "92fc7f1a6c26cbf496bf6ffa70ec1c2157b80fb4169d22283098cc91decdc301" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
