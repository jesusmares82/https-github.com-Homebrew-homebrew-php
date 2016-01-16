require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libsodium < AbstractPhp56Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.2.tar.gz"
  sha256 "294b82d26eb39123e200eba65fbe207f7a8053049c4ace1e411c264253fafb4f"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 1
    sha256 "5150185712c8c7fc1f1b22775e090c852987853404c3eff760c64e7b0186e8e2" => :el_capitan
    sha256 "3e6fe467b5233894da63a7cdce844bf68b9dc62ee07f4c799868a019a522b2d6" => :yosemite
    sha256 "d3e5886ce610902d446159924b42f0d6a163e2e5a387437f3e76daca28a84e75" => :mavericks
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
