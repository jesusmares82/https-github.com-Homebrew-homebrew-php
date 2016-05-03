require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pinba < AbstractPhp54Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "07410cfbdc412e62543ff4354151cb600c52e6afdaff46a70f9110d6d06b5beb" => :yosemite
    sha256 "4c5d7a4ad5e6ae867b7c730ef3c21e91466dc4231e2a0faa545403b61731ffef" => :mavericks
    sha256 "2e89252ce60b5f27cde912b62123818ce63a148bbb87b2d54a583700a9ccdf92" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pinba.so"

    write_config_file if build.with? "config-file"
  end
end
