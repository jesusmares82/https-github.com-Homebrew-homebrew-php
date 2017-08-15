require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Protobuf < AbstractPhp71Extension
  init
  desc "Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data."
  homepage "https://pecl.php.net/package/protobuf"
  url "https://pecl.php.net/get/protobuf-3.3.2.tgz"
  sha256 "01ee52961eb468149e23b36cf1f3ce1d2fab74bef3be988cac6e5c3d4651ff52"

  bottle do
    cellar :any_skip_relocation
    sha256 "c609ce590a954b233ea45be4888aa4d544bf01a2cd3409bc6ec7376bbeef4ebc" => :sierra
    sha256 "ef906debd654600db9051979e7a15d7e316d88e6379c23f081a00dc91b6df5ba" => :el_capitan
    sha256 "b2acb0eeabcf02672e2a06951d79e0349cca184d72013c405b631943b0cbda5a" => :yosemite
  end

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
