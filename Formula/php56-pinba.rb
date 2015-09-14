require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pinba < AbstractPhp56Extension
  init
  desc "PHP extension for Pinba monitoring server"
  homepage "http://pinba.org/"
  url "https://github.com/tony2001/pinba_extension/archive/6869f30e8c264e7a5742ab55f4f6bd5ee29e6080.tar.gz"
  sha256 "46e3640a47cd9b1951e6edbe637ba44ec5c858688883003c74ebe27a61e14fc5"
  head "https://github.com/tony2001/pinba_extension.git"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pinba.so"

    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("pinba")
  end
end
