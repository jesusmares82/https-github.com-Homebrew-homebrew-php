require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Sodium < AbstractPhp55Extension
  init
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.0.7.tar.gz"
  sha256 "07d06b486ab5b687e63109d64bf9fd21c846a315b8c71088639dfa0a7272339e"
  head "https://github.com/alethia7/php-sodium.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "7e12cccd99aa0c02b6f42ce60a7afb5f739379f881287f5ff7fba155bcba42b8" => :yosemite
    sha256 "34b928f8ba91b988734042b62387d64906298b35f6793c0a3dd7f7664445a38b" => :mavericks
    sha256 "24aa43cb27fbe214c47f726e5f53b731c77f00d7481ee81c003ee8d8c6727565" => :mountain_lion
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").split("\n").include?("sodium")
  end
end
