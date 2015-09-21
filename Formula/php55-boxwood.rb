require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Boxwood < AbstractPhp55Extension
  init
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    sha256 "bcc78ce1902f94cb4970706ff062caaa1d004833825e2ae75c311570073d8ecf" => :el_capitan
    sha256 "41fb9c688e4f320bc7faf2c6b8d2966b6353116a62465d25f992c2fa3001a00f" => :yosemite
    sha256 "d44cae77e6015992ff54bff6a8bb5159c376833bbdd17d40816f5045c488d87f" => :mavericks
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
