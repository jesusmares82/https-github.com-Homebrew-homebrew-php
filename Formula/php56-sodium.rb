require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sodium < AbstractPhp56Extension
  init
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.0.7.tar.gz"
  sha256 "07d06b486ab5b687e63109d64bf9fd21c846a315b8c71088639dfa0a7272339e"
  head "https://github.com/alethia7/php-sodium.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "208d2a38fd9a33ff86e4bec3b160052766cc7856b4a052213e53356a321d3544" => :yosemite
    sha256 "fcfd4274cf233f18a5887862c41809cccc063ab7fe4dfc2f0da5f8792103a91d" => :mavericks
    sha256 "afb4a12eca2f5e8eed214146facc4c0f23d7ecc5b9546424dc6ef7f3409f24b9" => :mountain_lion
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
