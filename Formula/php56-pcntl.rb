require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 3
    sha256 "21b1cb21d7aca26abe0f004b12b8f028bd22c4e9dc0ea71817a4aafb12be8b69" => :el_capitan
    sha256 "c7a6456f2b53d249ea9a93237a35a75facf2a9fd671d7dea53218871ced29f05" => :yosemite
    sha256 "da48d5f09b6ab6170b451a254469670cccbef59862813d53200ec38776ecf043" => :mavericks
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
