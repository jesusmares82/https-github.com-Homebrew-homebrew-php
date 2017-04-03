require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.2.0.tgz"
  sha256 "df205473888ad711e6c49df51732afee3e4fbcdd8dd717497531b733b22dd4ac"

  bottle do
    cellar :any_skip_relocation
    sha256 "2dad6e188bc2ded305e09f4b8142b60f4bbcb4de7de6ec5500a1b6c7da818aae" => :sierra
    sha256 "c9e39e5dbe820f94a5aaf4d59a8524e4c5d456caf8ab197e57e3982396913386" => :el_capitan
    sha256 "d0be21d815c0ddad7dffaae63c544f19b999ff6bdb04706944ab17bdfc08c5f0" => :yosemite
  end

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc=#{HOMEBREW_PREFIX}",
           "--prefix=#{prefix}", phpconfig,
           "CFLAGS=-Ithird_party/boringssl/include"
    system "make"
    prefix.install "modules/grpc.so"
    write_config_file if build.with? "config-file"
  end
end
