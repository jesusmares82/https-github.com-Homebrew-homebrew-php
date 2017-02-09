require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Grpc < AbstractPhp71Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.1.0.tgz"
  sha256 "4d7ad5d1994599d098f072688eb143ba73be12c58cf2c7d154189e68427c79ee"

  bottle do
    cellar :any_skip_relocation
    sha256 "88e4f1dc4e5f53bedd6c3b21357fb1548a3f3e9c5cad6ca7c02add0a1d123e05" => :sierra
    sha256 "c8de19bab7b6c51a8fd62a57bf776f9144817d6992d711b953770ad3df286198" => :el_capitan
    sha256 "33f78f3410e4bf8f652f035e8e519d575a347995635986a5868a94a9a3e4a13b" => :yosemite
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
