require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 13
    sha256 "034027ad0faa7cef4bc2fc8f8a72f72e012ca0e6a15446f549b30534967a13da" => :el_capitan
    sha256 "1db7b3e77ccb432ec723925c812714aa5405fac4a72364e2f52d65bcf403d313" => :yosemite
    sha256 "fee6d77ecb65d546b30a952f5137959a49dac6b097098aa0375029bece94d859" => :mavericks
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






