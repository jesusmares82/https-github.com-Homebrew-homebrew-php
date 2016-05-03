require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pinba < AbstractPhp56Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/7e7cd25ebcd74234f058bfe350128238383c6b96.tar.gz"
  sha256 "bed4ffc980f407a433e0fcf8f2309537f7914d6d33349a1ea1ce14ab37127462"
  head "https://github.com/tony2001/pinba_extension.git"
  version "1.1.0-dev.7e7cd25"

  bottle do
    cellar :any_skip_relocation
    sha256 "a88ee4739502ac333792b86b2183f900b4950c03975fe28e8eaea34029be9599" => :yosemite
    sha256 "a06ea73967e5a3b35f403169799fe8786f874a0abbb330dea9d97406db881a54" => :mavericks
    sha256 "2e4625c550e41b4a48f456b516cc3fb856256cfd0097947f0aa5c3980d48d678" => :mountain_lion
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
