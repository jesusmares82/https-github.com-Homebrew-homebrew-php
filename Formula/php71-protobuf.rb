require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Protobuf < AbstractPhp71Extension
  init
  desc "Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data."
  homepage "https://pecl.php.net/package/protobuf"
  url "https://pecl.php.net/get/protobuf-3.3.2.tgz"
  sha256 "01ee52961eb468149e23b36cf1f3ce1d2fab74bef3be988cac6e5c3d4651ff52"

  depends_on "protobuf"

  def install
    Dir.chdir "protobuf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
