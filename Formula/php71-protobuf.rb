require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Protobuf < AbstractPhp71Extension
  init
  desc "Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data."
  homepage "https://pecl.php.net/package/protobuf"
  url "https://pecl.php.net/get/protobuf-3.4.0.tgz"
  sha256 "510d8ea544e3d5fc44fa5d13f6db5dd7af3e292aee66f90409f95f4450414a71"

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
