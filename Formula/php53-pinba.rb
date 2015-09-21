require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pinba < AbstractPhp53Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/6869f30e8c264e7a5742ab55f4f6bd5ee29e6080.tar.gz"
  sha256 "46e3640a47cd9b1951e6edbe637ba44ec5c858688883003c74ebe27a61e14fc5"
  head "https://github.com/tony2001/pinba_extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dd5a7df7ab2a79b75eb368bf8ff46e55f394b2eac8523a3af05eb11ee286748f" => :yosemite
    sha256 "bfd692ac1374c80f04de63c843b79dd9fb50d2ff444da6c6dfd27bd8bb4c6b25" => :mavericks
    sha256 "6cabe56cc31318fce81c9a35b69438d4cb186d5a25a727bffcdcad72f3f6bb8c" => :mountain_lion
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
