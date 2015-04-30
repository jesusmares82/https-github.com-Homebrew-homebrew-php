require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libsodium < AbstractPhp54Extension
  init
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "40beb4ea33155ca002ff818f1e4a222f38a7aceb08ba82039fb72698622bb431" => :yosemite
    sha256 "d923e04bb243cb2719e088811ae8180198eb93829aab651c4d0d25040289d414" => :mavericks
    sha256 "31e8165cc32cbb849bd0828aa09fd38cf2b40aa0dd6b748801a30a892e7c843b" => :mountain_lion
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
