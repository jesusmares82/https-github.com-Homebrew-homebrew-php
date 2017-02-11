require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Grpc < AbstractPhp55Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.1.0.tgz"
  sha256 "4d7ad5d1994599d098f072688eb143ba73be12c58cf2c7d154189e68427c79ee"

  bottle do
    cellar :any_skip_relocation
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
