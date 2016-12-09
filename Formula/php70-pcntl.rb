require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 6

  bottle do
    cellar :any_skip_relocation
    sha256 "45bf41b5bff06066a0ac1ab628c1ea0f858a55fd562c41ef46725607d798a98c" => :sierra
    sha256 "007933bc6fef50de0c149e4b4bc5ab21b3a6cb6eccad3c11dd769aa94bf958fb" => :el_capitan
    sha256 "0a9da405d6a26093a5a2a20fbf62b81f46fb1b446584dcc8d753308bd4c1b3c5" => :yosemite
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
