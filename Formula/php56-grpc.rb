require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.0.1.tgz"
  sha256 "53fc9972d8817ae96c2d3e882bfdea939d1da7faf66e340364be16dde93d8b54"

  bottle do
    cellar :any_skip_relocation
    sha256 "bdbc0e1de88c7409f9f92ef824f99b4c585a2cd76ab562154fd31e3bd7515880" => :sierra
    sha256 "4af946a68bc2cc89ebabbe892738033013f3cad42e1cb8d2636e6d1f0fd27139" => :el_capitan
    sha256 "812cdd72bcb8eb94936332f67b14d43aab79221d5af6c92af070c5e254b845af" => :yosemite
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
