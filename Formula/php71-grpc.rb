require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Grpc < AbstractPhp71Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "https://grpc.io"
  url "https://pecl.php.net/get/grpc-1.6.0.tgz"
  sha256 "ded14216247457c04a5e5baf9d3cd44984f4f8042ea4677adfe432ae75c19f09"

  bottle do
    cellar :any_skip_relocation
    sha256 "b50d01f170f2d30f63cd4aaf86f2e030b88125a9c9447853c64686d0acf2562c" => :sierra
    sha256 "58c07e815b79b874afb405465b2f2bbd2f07109feada5fd1f31ea6ecad091505" => :el_capitan
    sha256 "3e44e7d3149e646d97c13666210f0db742be6c7a530958bf40826dc45086e096" => :yosemite
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
