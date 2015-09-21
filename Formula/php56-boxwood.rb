require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Boxwood < AbstractPhp56Extension
  init
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    sha256 "49a426d8880ece7ce8008d9b68675a685fb9e2e9e46beaa31d0ee29879f5b860" => :el_capitan
    sha256 "ce40a720dcb33aedf2672f8d25371296d197995811e3ac4edb2bd6cd99c2b994" => :yosemite
    sha256 "a4898e0a289ee63b11eac6c7efb60dc87c1cba5a57255fc66f939665ab995b42" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig

    system "make"
    prefix.install "modules/boxwood.so"
    write_config_file if build.with? "config-file"
  end
end
