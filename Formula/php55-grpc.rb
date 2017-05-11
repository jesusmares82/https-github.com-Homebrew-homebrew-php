require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Grpc < AbstractPhp55Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.3.2.tgz"
  sha256 "5ebb79868857155471b563751fb726b45da18e5a5708878253937bae0e629a84"

  bottle do
    cellar :any_skip_relocation
    sha256 "97ea6c17a404e4cbbef5dc672f812b2ab23d6597d7988d9b2bb36dd943aea986" => :sierra
    sha256 "a989ad06bea88cc5a40804e3bb27a617cf8d213163d7259a7c7e94f79053510c" => :el_capitan
    sha256 "a5e34bbffa6752677fd80012c3cd640c9ce30d56d77c9805c07c1cd86bb94c8f" => :yosemite
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
