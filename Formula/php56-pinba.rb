require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pinba < AbstractPhp56Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/6869f30e8c264e7a5742ab55f4f6bd5ee29e6080.tar.gz"
  sha256 "46e3640a47cd9b1951e6edbe637ba44ec5c858688883003c74ebe27a61e14fc5"
  head "https://github.com/tony2001/pinba_extension.git"

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
