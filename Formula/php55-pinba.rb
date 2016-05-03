require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pinba < AbstractPhp55Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c17646ab09ce26e0d71a8121e84df99b622e1a66b8f8dc54def03c3d6c878ef" => :yosemite
    sha256 "42435bdc31942a608424faa0adcff39c628c5a431d1658c691c8dddc3fb38596" => :mavericks
    sha256 "070924963db6e1ee89a1a7c8f83671950ae84803c6b805d85339a905c9a3e83f" => :mountain_lion
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
