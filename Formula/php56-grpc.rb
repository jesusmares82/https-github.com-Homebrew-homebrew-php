require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Grpc < AbstractPhp56Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.3.2.tgz"
  sha256 "5ebb79868857155471b563751fb726b45da18e5a5708878253937bae0e629a84"

  bottle do
    cellar :any_skip_relocation
    sha256 "dbf154826210f177bd559ec541fcd7d86f001b1ebbe8caffb8b64e94f647a7f6" => :sierra
    sha256 "2d7d48c44f1ddc423f8edf606c364745624fe7d01c3c7a5a1df0888a49c9828d" => :el_capitan
    sha256 "eaad28f6dbd6f119f89c17be29cbee46408c8d91a90e1190005195adc9adc019" => :yosemite
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
