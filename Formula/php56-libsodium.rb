require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libsodium < AbstractPhp56Extension
  init
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "fbe9bbb4a2b7b55766c4ed721e42479ce569396d1e65c0558cfa610cb64ce426" => :yosemite
    sha256 "168ec2cb73b5216de8030948f994484c05ffcc0f1f20dab4c020b1c10efe9b60" => :mavericks
    sha256 "3c88effd48d31d2626202c3f1ec98402d6c5e3887bb6e4e31026c0fc95160065" => :mountain_lion
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("libsodium")
  end
end
