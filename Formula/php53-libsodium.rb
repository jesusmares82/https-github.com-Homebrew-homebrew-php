require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libsodium < AbstractPhp53Extension
  init
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "665a2fce3f413a9a377378beb44ded115fe4c5c1175d34314beb10f0758c9b67" => :yosemite
    sha256 "9a6674137246569b841cefa416483c692d66835d60eb13268cc0083ce73c759a" => :mavericks
    sha256 "43bc81d994953ca809bd50dc387220c873cbe6a4fda232edfe2f0adf349107fe" => :mountain_lion
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
