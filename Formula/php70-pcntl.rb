require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 5
    sha256 "9fa6e954f4c6ef910a0798d9480556e17439008155182f7e2528013c727973dc" => :el_capitan
    sha256 "351316acfb5efa5c39810a6b3ca0b86bf91033ea1ac9004a49366e01580bd9bd" => :yosemite
    sha256 "a9ddbb6f227122480da962279441664000db3789b844d2b3e18644d84a008c3d" => :mavericks
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
