require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 15

  bottle do
    cellar :any_skip_relocation
    sha256 "9b9f2dcb48b0eed85e2c9a363c584355d5085c7134276e117ba06bd7999fa804" => :high_sierra
    sha256 "b8cdd28bee5cc24ea26437b43c0c3b7192cde1cec50b0db741e36e52b3a46642" => :sierra
    sha256 "1add220a8c242e5d0b2dfc6287403dc3ccec0ed93fe71fc024884e5100fe065e" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
