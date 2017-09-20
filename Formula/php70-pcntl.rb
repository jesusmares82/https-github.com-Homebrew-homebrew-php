require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 14

  bottle do
    cellar :any_skip_relocation
    sha256 "bbd8268363bfa058e3211484270d7da1f68aa12e78af9cef416ed4d58a27fb12" => :sierra
    sha256 "43bc575b495a16ea2559a5243d4d8c11693b09fb969f13b6ce9d495b2cfcbed9" => :el_capitan
    sha256 "9e3ce9acd8083548e21d3f2a496fed087d5423d62643ddf6e964e2cc7442a066" => :yosemite
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
