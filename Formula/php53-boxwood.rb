require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Boxwood < AbstractPhp53Extension
  init
  desc "PHP extension for fast replacement of multiple words in a piece of text"
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    sha256 "862ba5994553fb6ced9d5933d28354bc334884318a45fe45b5e0ba12ad9ff080" => :el_capitan
    sha256 "93d5fd5b2b96c9bf985fa1033b1c34449780ecd4cd61ad8393ce36cd7200e098" => :yosemite
    sha256 "ad7ae7bd862d1ced1e77243c324345b4ceb79718c343465343e2908dba74712c" => :mavericks
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
