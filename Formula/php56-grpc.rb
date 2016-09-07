require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.0.0.tgz"
  sha256 "8c4d116d5d34aa5a9650ef59405b82209b8db8f3f027865a8e9fd6ec5cea6e77"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b3ba07c93704866e35f15d3c28a95a63676c1302b6455c2e82e3a6d030c7357" => :el_capitan
    sha256 "55c01dacba0888b77875c3512bb048a15bcaf09c4b27ba571ae8b011de5aac69" => :yosemite
    sha256 "e81cc3fc9f067ee71afcd63c341a8160fedf1cad3a8eb256c414b10af86f0283" => :mavericks
  end

  depends_on "grpc/grpc/grpc"

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
