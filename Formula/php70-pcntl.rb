require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 7
    sha256 "b5cbcbe046ac414df0e2f9243e6ef06a541cfc1e571a44205c01cd2d6ce24283" => :el_capitan
    sha256 "2e2eb40b8d87a15fcf3123b8789b60884665ec7583fc4dba43d8b84c5b47f218" => :yosemite
    sha256 "25eb657b98105fd5ff8ccb9e9f5c5938277a3539c76bb9edde8eea063b2febee" => :mavericks
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
