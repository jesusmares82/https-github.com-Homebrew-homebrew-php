require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Grpc < AbstractPhp71Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.3.2.tgz"
  sha256 "5ebb79868857155471b563751fb726b45da18e5a5708878253937bae0e629a84"

  bottle do
    cellar :any_skip_relocation
    sha256 "d21d891fde38318e2d86a9b23e8ac43312e338baa46b62cca77b25b00d71ff55" => :sierra
    sha256 "b7c6be6c660bf3a7691a754a64e471ea6776ce8a037ddf7132a457e212065a60" => :el_capitan
    sha256 "656167b6fe9d66a4fe7555627d998c81d1689b78973b77d7862f13254f5b8ba1" => :yosemite
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
