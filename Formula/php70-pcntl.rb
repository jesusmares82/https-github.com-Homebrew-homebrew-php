require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 16

  bottle do
    cellar :any_skip_relocation
    sha256 "1752e1c30ccd9fa6a73d2705221ed7ebcaad6520dfcc8260a28048b91ad4f24c" => :high_sierra
    sha256 "bc4a3f76dfde6845068be46b06312794a6416fa6b2b5da5b8ada4c064b5e362e" => :sierra
    sha256 "99fee5aa60ede395a06e18bc08f225a78605321cc7049514d1bdbd14a2e51ef8" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
