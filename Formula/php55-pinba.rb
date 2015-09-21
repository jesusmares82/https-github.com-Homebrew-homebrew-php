require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pinba < AbstractPhp55Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/6869f30e8c264e7a5742ab55f4f6bd5ee29e6080.tar.gz"
  sha256 "46e3640a47cd9b1951e6edbe637ba44ec5c858688883003c74ebe27a61e14fc5"
  head "https://github.com/tony2001/pinba_extension.git"

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
