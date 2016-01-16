require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Libsodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.2.tar.gz"
  sha256 "294b82d26eb39123e200eba65fbe207f7a8053049c4ace1e411c264253fafb4f"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "95c48884b208002ce0c9c5a0e1835df8b285c4bdddc6de02857607dcdecdf32b" => :el_capitan
    sha256 "77ae5a610f4c2891198d88b9d3df24989e100a9aa5e953d7842a4fa10d0987c8" => :yosemite
    sha256 "f28d4036e322acb901a1858228d28cdd94d4e053554e092d9a89e76f7a91f8c2" => :mavericks
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
end
