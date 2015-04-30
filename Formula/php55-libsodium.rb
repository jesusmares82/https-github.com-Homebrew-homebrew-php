require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Libsodium < AbstractPhp55Extension
  init
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "43a485df26e4d611e8df9d56e0a6af3f6bfface8b6f8ca56ef4dac420af5ea62" => :yosemite
    sha256 "74f2cef5210e464a51a582b2e9e75761bcf0fdfc342b1f7718105771e324ad5e" => :mavericks
    sha256 "a8542ea747a5b7a7668e857729b5545f072f13f06cb2615fdd26039687407a3c" => :mountain_lion
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
