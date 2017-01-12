require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.0.1.tgz"
  sha256 "53fc9972d8817ae96c2d3e882bfdea939d1da7faf66e340364be16dde93d8b54"

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
