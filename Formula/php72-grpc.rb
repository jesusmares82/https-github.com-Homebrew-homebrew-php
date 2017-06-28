require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Grpc < AbstractPhp72Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.3.2.tgz"
  sha256 "5ebb79868857155471b563751fb726b45da18e5a5708878253937bae0e629a84"

  bottle do
    cellar :any_skip_relocation
    sha256 "a84caca63d400448e28d9501a1d54ae341f584121bba9b9d7ae5a5f6bd0f5b0a" => :sierra
    sha256 "e4130e109aef7e69c7cfeb71c781115e7455d562b0f8465aac1e7b34e07bf10c" => :el_capitan
    sha256 "513ef786c0658a997b169ab2acec0d2e8af20d6ded5703fc8d5e26ca66c75e51" => :yosemite
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
