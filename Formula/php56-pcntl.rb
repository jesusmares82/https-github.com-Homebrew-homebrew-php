require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 10
    sha256 "f108f072010430392f674aca11160a5ef1dc700fa3ae827c97231eb806bf2bc7" => :el_capitan
    sha256 "1639fffeae55e450e9039c35e471af48b46eb3ff6b6f6f72579ceb99e2d500f5" => :yosemite
    sha256 "064c600e1d23d67125690814833e97b1da19297adfbcaaabbf53b20d629f6c29" => :mavericks
  end

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






